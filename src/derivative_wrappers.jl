function derivative!(df::AbstractArray{<:Number}, f, x::Union{Number,AbstractArray{<:Number}}, fx::AbstractArray{<:Number}, integrator, grad_config)
    alg = unwrap_alg(integrator, true)
    tmp = length(x) # We calculate derivtive for all elements in gradient
    if alg_autodiff(alg)
        ForwardDiff.derivative!(df, f, fx, x, grad_config)
        integrator.destats.nf += 1
    else
        DiffEqDiffTools.finite_difference_gradient!(df, f, x, grad_config, dir = diffdir(integrator))
        fdtype = alg.diff_type
        if fdtype == Val{:forward} || fdtype == Val{:central}
            tmp *= 2
            if eltype(df)<:Complex
              tmp *= 2
            end
        end
        integrator.destats.nf += tmp
    end
    nothing
end

function derivative(f, x::Union{Number,AbstractArray{<:Number}},
                    integrator)
    local d
    tmp = length(x) # We calculate derivtive for all elements in gradient
    alg = unwrap_alg(integrator, true)
    if alg_autodiff(alg)
      integrator.destats.nf += 1
      d = ForwardDiff.derivative(f, x)
    else
      d = DiffEqDiffTools.finite_difference_derivative(f, x, alg.diff_type, dir = diffdir(integrator))
      if alg.diff_type == Val{:central} || alg.diff_type == Val{:forward}
          tmp *= 2
      end
      integrator.destats.nf += tmp
      d
    end
end

function jacobian(f, x, integrator)
    alg = unwrap_alg(integrator, true)
    local tmp
    if alg_autodiff(alg)
      J = jacobian_autodiff(f, x)
      tmp = 1
    else
      J = jacobian_finitediff(f, x, alg.diff_type, integrator)
      N = length(x)
      if alg.diff_type==Val{:complex} && eltype(x)<:Real
        tmp = N
      elseif alg.diff_type==Val{:forward}
        tmp = N + 1
      else
        tmp = 2N
      end
    end
    integrator.destats.nf += tmp
    J
end

jacobian_autodiff(f, x) = ForwardDiff.derivative(f,x)
jacobian_autodiff(f, x::AbstractArray) = ForwardDiff.jacobian(f, x)

jacobian_finitediff(f, x, diff_type, integrator) =
    DiffEqDiffTools.finite_difference_derivative(f, x, diff_type, eltype(x), dir = diffdir(integrator))
jacobian_finitediff(f, x::AbstractArray, diff_type, integrator) =
    DiffEqDiffTools.finite_difference_jacobian(f, x, diff_type, eltype(x), Val{false}, dir = diffdir(integrator))

function jacobian!(J::AbstractMatrix{<:Number}, f, x::AbstractArray{<:Number}, fx::AbstractArray{<:Number}, integrator::DiffEqBase.DEIntegrator, jac_config)
    alg = unwrap_alg(integrator, true)
    if alg_autodiff(alg)
      ForwardDiff.jacobian!(J, f, fx, x, jac_config)
      integrator.destats.nf += 1
    else
      isforward = alg.diff_type === Val{:forward}
      if isforward
        forwardcache = get_tmp_cache(integrator, alg, unwrap_cache(integrator, true))[2]
        f(forwardcache, x)
        integrator.destats.nf += 1
        DiffEqDiffTools.finite_difference_jacobian!(J, f, x, jac_config, forwardcache, dir = diffdir(integrator))
      else # not forward difference
        DiffEqDiffTools.finite_difference_jacobian!(J, f, x, jac_config)
      end
      integrator.destats.nf += (alg.diff_type==Val{:complex} && eltype(x)<:Real || isforward) ? length(x) : 2length(x)
    end
    nothing
end

function DiffEqBase.build_jac_config(alg::OrdinaryDiffEqAlgorithm,f,uf,du1,uprev,u,tmp,du2)
  if !DiffEqBase.has_jac(f)
    if alg_autodiff(alg)
      jac_config = ForwardDiff.JacobianConfig(uf,du1,uprev,ForwardDiff.Chunk{determine_chunksize(u,alg)}())
    else
      if alg.diff_type != Val{:complex}
        jac_config = DiffEqDiffTools.JacobianCache(tmp,du1,du2,alg.diff_type)
      else
        jac_config = DiffEqDiffTools.JacobianCache(Complex{eltype(tmp)}.(tmp),Complex{eltype(du1)}.(du1),nothing,alg.diff_type,eltype(u))
      end
    end
  else
    jac_config = nothing
  end
  jac_config
end

function build_grad_config(alg,f,tf,du1,t)
  if !DiffEqBase.has_tgrad(f)
    if alg_autodiff(alg)
      grad_config = ForwardDiff.DerivativeConfig(tf,du1,t)
    else
      grad_config = DiffEqDiffTools.GradientCache(du1,t,alg.diff_type)
    end
  else
    grad_config = nothing
  end
  grad_config
end
