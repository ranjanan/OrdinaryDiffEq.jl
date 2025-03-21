using SafeTestsets
const LONGER_TESTS = false

const GROUP = get(ENV, "GROUP", "All")
const is_APPVEYOR = Sys.iswindows() && haskey(ENV,"APPVEYOR")
const is_TRAVIS = haskey(ENV,"TRAVIS")

#Start Test Script

@time begin
if GROUP == "All" || GROUP == "Interface"
  @time @safetestset "Discrete Algorithm Tests" begin include("interface/discrete_algorithm_test.jl") end
  @time @safetestset "Tstops Tests" begin include("interface/ode_tstops_tests.jl") end
  @time @safetestset "Backwards Tests" begin include("interface/ode_backwards_test.jl") end
  @time @safetestset "Initdt Tests" begin include("interface/ode_initdt_tests.jl") end
  @time @safetestset "Linear Tests" begin include("interface/ode_twodimlinear_tests.jl") end
  @time @safetestset "Mass Matrix Tests" begin include("interface/mass_matrix_tests.jl") end
  @time @safetestset "Differentiation Trait Tests" begin include("interface/differentiation_traits_tests.jl") end
  @time @safetestset "Inf Tests" begin include("interface/inf_handling.jl") end
  @time @safetestset "Jacobian Tests" begin include("interface/jacobian_tests.jl") end
  @time @safetestset "saveat Tests" begin include("interface/ode_saveat_tests.jl") end
  @time @safetestset "save_idxs Tests" begin include("interface/ode_saveidxs_tests.jl") end
  @time @safetestset "Static Array Tests" begin include("interface/static_array_tests.jl") end
  @time @safetestset "Data Array Tests" begin include("interface/data_array_test.jl") end
  @time @safetestset "u_modifed Tests" begin include("interface/umodified_test.jl") end
  @time @safetestset "Composite Algorithm Tests" begin include("interface/composite_algorithm_test.jl") end
  @time @safetestset "Complex Tests" begin include("interface/complex_tests.jl") end
  @time @safetestset "Ndim Complex Tests" begin include("interface/ode_ndim_complex_tests.jl") end
  @time @safetestset "Number Type Tests" begin include("interface/ode_numbertype_tests.jl") end
  @time @safetestset "Stiffness Detection Tests" begin include("interface/stiffness_detection_test.jl") end
  @time @safetestset "Composite Interpolation Tests" begin include("interface/composite_interpolation.jl") end
  @time @safetestset "Export tests" begin include("interface/export_tests.jl") end
  @time @safetestset "Derivative Utilities Tests" begin include("interface/utility_tests.jl") end
  @time @safetestset "DEStats Tests" begin include("interface/destats_tests.jl") end
  @time @safetestset "AD Tests" begin include("interface/ad_tests.jl") end
  @time @safetestset "No Index Tests" begin include("interface/noindex_tests.jl") end
  @time @safetestset "Units Tests" begin include("interface/units_tests.jl") end
  @time @safetestset "Linear Nonlinear Solver Tests" begin include("interface/linear_nonlinear_tests.jl") end
end

if !is_APPVEYOR && (GROUP == "All" || GROUP == "Integrators")
  @time @safetestset "Reinit Tests" begin include("integrators/reinit_test.jl") end
  @time @safetestset "Events Tests" begin include("integrators/ode_event_tests.jl") end
  @time @safetestset "Alg Events Tests" begin include("integrators/alg_events_tests.jl") end
  @time @safetestset "Autodiff Events Tests" begin include("integrators/autodiff_events.jl") end
  @time @safetestset "Cache Tests" begin include("integrators/ode_cache_tests.jl") end
  @time @safetestset "Discrete Callback Dual Tests" begin include("integrators/discrete_callback_dual_test.jl") end
  @time @safetestset "Iterator Tests" begin include("integrators/iterator_tests.jl") end
  @time @safetestset "Integrator Interface Tests" begin include("integrators/integrator_interface_tests.jl") end
  @time @safetestset "Add Steps Tests" begin include("integrators/ode_add_steps_tests.jl") end
  @time @safetestset "Error Check Tests" begin include("integrators/check_error.jl") end
  @time @safetestset "Event Detection Tests" begin include("integrators/event_detection_tests.jl") end
  @time @safetestset "Differentiation Direction Tests" begin include("integrators/diffdir_tests.jl") end
end

if !is_APPVEYOR && (GROUP == "All" || GROUP == "Regression")
  @time @safetestset "Dense Tests" begin include("regression/ode_dense_tests.jl") end
  @time @safetestset "Inplace Tests" begin include("regression/ode_inplace_tests.jl") end
  @time @safetestset "Adaptive Tests" begin include("regression/ode_adaptive_tests.jl") end
  @time @safetestset "PSOS Energy Conservation Tests" begin include("regression/psos_and_energy_conservation.jl") end
  @time @safetestset "Unrolled Tests" begin include("regression/ode_unrolled_comparison_tests.jl") end
  @time @safetestset "Time derivative Tests" begin include("regression/time_derivative_test.jl") end
end

if !is_APPVEYOR && (GROUP == "All" || GROUP == "AlgConvergence_I")
  @time @safetestset "Partitioned Methods Tests" begin include("algconvergence/partitioned_methods_tests.jl") end
  @time @safetestset "Convergence Tests" begin include("algconvergence/ode_convergence_tests.jl") end
  @time @safetestset "Adams Variable Coefficients Tests" begin include("algconvergence/adams_tests.jl") end
  @time @safetestset "Nordsieck Tests" begin include("algconvergence/nordsieck_tests.jl") end
  @time @safetestset "Linear Methods Tests" begin include("algconvergence/linear_method_tests.jl") end
  @time @safetestset "Extrapolation Tests" begin include("algconvergence/ode_extrapolation_tests.jl") end
end

if !is_APPVEYOR && (GROUP == "All" || GROUP == "AlgConvergence_II")
  @time @safetestset "SSPRK Tests" begin include("algconvergence/ode_ssprk_tests.jl") end
  @time @safetestset "Low Storage RK Tests" begin include("algconvergence/ode_low_storage_rk_tests.jl") end
  @time @safetestset "OwrenZen Tests" begin include("algconvergence/owrenzen_tests.jl") end
  @time @safetestset "Runge-Kutta-Chebyshev Tests" begin include("algconvergence/rkc_tests.jl") end
end

if !is_APPVEYOR && (GROUP == "All" || GROUP == "AlgConvergence_III")
  @time @safetestset "Split Methods Tests" begin include("algconvergence/split_methods_tests.jl") end
  @time @safetestset "Rosenbrock Tests" begin include("algconvergence/ode_rosenbrock_tests.jl") end
  @time @safetestset "FIRK Tests" begin include("algconvergence/ode_firk_tests.jl") end
  @time @safetestset "Linear-Nonlinear Methods Tests" begin include("algconvergence/linear_nonlinear_convergence_tests.jl") end
  @time @safetestset "Linear-Nonlinear Krylov Methods Tests" begin include("algconvergence/linear_nonlinear_krylov_tests.jl") end
  @time @safetestset "Feagin Tests" begin include("algconvergence/ode_feagin_tests.jl") end
end

if !is_APPVEYOR && GROUP == "ODEInterfaceRegression"
  if is_TRAVIS
    using Pkg
    Pkg.add("ODEInterface")
    Pkg.add("ODEInterfaceDiffEq")
  end
  @time @safetestset "Init dt vs dorpri tests" begin include("odeinterface/init_dt_vs_dopri_tests.jl") end
  @time @safetestset "ODEInterface Regression Tests" begin include("odeinterface/odeinterface_regression.jl") end
end

if !is_APPVEYOR && GROUP == "GPU"
  @time @safetestset "Simple GPU" begin include("gpu/simple_gpu.jl") end
end

end # @time
