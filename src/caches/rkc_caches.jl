mutable struct ROCK2ConstantCache{T,T2,zType} <: OrdinaryDiffEqConstantCache
  ms::SVector{46, Int}
  fp1::SVector{46, T}
  fp2::SVector{46, T}
  recf::Vector{T2}
  zprev::zType
  mdeg::Int
  deg_index::Int
  start::Int
  min_stage::Int
  max_stage::Int
end
@cache struct ROCK2Cache{uType,rateType,uNoUnitsType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  uᵢ₋₁::uType
  uᵢ₋₂::uType
  tmp::uType
  atmp::uNoUnitsType
  fsalfirst::rateType
  k::rateType
  constantcache::ROCK2ConstantCache
end

function alg_cache(alg::ROCK2,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  constantcache = ROCK2ConstantCache(uEltypeNoUnits, uEltypeNoUnits, u)
  uᵢ₋₁ = similar(u)
  uᵢ₋₂ = similar(u)
  tmp = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  fsalfirst = zero(rate_prototype)
  k = zero(rate_prototype)
  ROCK2Cache(u, uprev, uᵢ₋₁, uᵢ₋₂, tmp, atmp, fsalfirst, k, constantcache)
end

function alg_cache(alg::ROCK2,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  ROCK2ConstantCache(uEltypeNoUnits, uEltypeNoUnits, u)
end

mutable struct ROCK4ConstantCache{T,T2,T3,T4,zType} <: OrdinaryDiffEqConstantCache
  ms::SVector{50, Int}
  fpa::Vector{T}
  fpb::Vector{T2}
  fpbe::Vector{T3}
  recf::Vector{T4}
  zprev::zType
  mdeg::Int
  deg_index::Int
  start::Int
  min_stage::Int
  max_stage::Int
end

@cache struct ROCK4Cache{uType,rateType,uNoUnitsType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  uᵢ₋₁::uType
  uᵢ₋₂::uType
  uᵢ₋₃::uType
  tmp::uType
  atmp::uNoUnitsType
  fsalfirst::rateType
  k::rateType
  constantcache::ROCK4ConstantCache
end

function alg_cache(alg::ROCK4,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  constantcache = ROCK4ConstantCache(real(uEltypeNoUnits), real(uEltypeNoUnits), u)
  uᵢ₋₁ = similar(u)
  uᵢ₋₂ = similar(u)
  uᵢ₋₃ = similar(u)
  tmp = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  fsalfirst = zero(rate_prototype)
  k = zero(rate_prototype)
  ROCK4Cache(u, uprev, uᵢ₋₁, uᵢ₋₂, uᵢ₋₃, tmp, atmp, fsalfirst, k, constantcache)
end

function alg_cache(alg::ROCK4,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  ROCK4ConstantCache(real(uEltypeNoUnits), real(uEltypeNoUnits),u)
end

mutable struct RKCConstantCache{zType} <: OrdinaryDiffEqConstantCache
  #to match the types to call maxeig!
  zprev::zType
end
@cache struct RKCCache{uType,rateType,uNoUnitsType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  gprev::uType
  gprev2::uType
  tmp::uType
  atmp::uNoUnitsType
  fsalfirst::rateType
  k::rateType
  constantcache::RKCConstantCache
end

function alg_cache(alg::RKC,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  constantcache = RKCConstantCache(u)
  gprev = similar(u)
  gprev2 = similar(u)
  tmp = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  fsalfirst = zero(rate_prototype)
  k = zero(rate_prototype)
  RKCCache(u, uprev, gprev, gprev2, tmp, atmp, fsalfirst, k, constantcache)
end

function alg_cache(alg::RKC,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  RKCConstantCache(u)
end

@cache mutable struct IRKCConstantCache{uType,rateType,F,N} <: OrdinaryDiffEqConstantCache
  minm::Int64
  zprev::uType
  uf::F
  nlsolver::N
  du₁::rateType
  du₂::rateType
end

@cache mutable struct IRKCCache{uType,rateType,uNoUnitsType,JType,WType,UF,JC,N,F} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  gprev::uType
  gprev2::uType
  fsalfirst::rateType
  k::rateType
  du1::rateType
  f1ⱼ₋₁::rateType
  f1ⱼ₋₂::rateType
  f2ⱼ₋₁::rateType
  z::uType
  dz::uType
  tmp::uType
  atmp::uNoUnitsType
  J::JType
  W::WType
  uf::UF
  jac_config::JC
  linsolve::F
  nlsolver::N
  du₁::rateType
  du₂::rateType
  constantcache::IRKCConstantCache
end

function alg_cache(alg::IRKC,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  γ, c = 1.0, 1.0
  W = oop_generate_W(alg,u,uprev,p,t,dt,f,uEltypeNoUnits)
  nlsolver = oopnlsolve(alg,u,uprev,p,t,dt,f,W,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,γ,c)
  @getoopnlsolvefields
  zprev = u
  du₁ = rate_prototype; du₂ = rate_prototype
  IRKCConstantCache(50,zprev,uf,nlsolver,du₁,du₂)
end

function alg_cache(alg::IRKC,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  γ, c = 1.0, 1.0
  J, W = iip_generate_W(alg,u,uprev,p,t,dt,f,uEltypeNoUnits)
  nlsolver = iipnlsolve(alg,u,uprev,p,t,dt,f,W,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,γ,c)
  @getiipnlsolvefields

  gprev = similar(u)
  gprev2 = similar(u)
  tmp = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  fsalfirst = zero(rate_prototype)
  k  = zero(rate_prototype)
  zprev = similar(u)
  f1ⱼ₋₁ = zero(rate_prototype)
  f1ⱼ₋₂ = zero(rate_prototype)
  f2ⱼ₋₁ = zero(rate_prototype)
  du₁ = zero(rate_prototype)
  du₂ = zero(rate_prototype)
  constantcache = IRKCConstantCache(50,zprev,uf,nlsolver,du₁,du₂)
  IRKCCache(u,uprev,gprev,gprev2,fsalfirst,k,du1,f1ⱼ₋₁,f1ⱼ₋₂,f2ⱼ₋₁,z,dz,tmp,atmp,J,W,uf,jac_config,linsolve,nlsolver,du₁,du₂,constantcache)
end

mutable struct ESERK4ConstantCache{T, zType} <: OrdinaryDiffEqConstantCache
  ms::SVector{46, Int}
  Cᵤ::SVector{4, Int}
  Cₑ::SVector{4, Int}
  zprev::zType
  Bᵢ::Vector{T}
  mdeg::Int
  start::Int
  internal_deg::Int
end

@cache struct ESERK4Cache{uType,rateType,uNoUnitsType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  uᵢ::uType
  uᵢ₋₁::uType
  uᵢ₋₂::uType
  Sᵢ::uType
  tmp::uType
  atmp::uNoUnitsType
  fsalfirst::rateType
  k::rateType
  constantcache::ESERK4ConstantCache
end

function alg_cache(alg::ESERK4,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  constantcache = ESERK4ConstantCache(u)
  uᵢ = similar(u)
  uᵢ₋₁ = similar(u)
  uᵢ₋₂ = similar(u)
  Sᵢ   = similar(u)
  tmp = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  fsalfirst = zero(rate_prototype)
  k = zero(rate_prototype)
  ESERK4Cache(u, uprev, uᵢ, uᵢ₋₁, uᵢ₋₂, Sᵢ, tmp, atmp, fsalfirst, k, constantcache)
end

function alg_cache(alg::ESERK4,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  ESERK4ConstantCache(u)
end

mutable struct ESERK5ConstantCache{T, zType} <: OrdinaryDiffEqConstantCache
  ms::SVector{49, Int}
  Cᵤ::SVector{5, Int}
  Cₑ::SVector{5, Int}
  zprev::zType
  Bᵢ::Vector{T}
  mdeg::Int
  start::Int
  internal_deg::Int
end

@cache struct ESERK5Cache{uType,rateType,uNoUnitsType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  uᵢ::uType
  uᵢ₋₁::uType
  uᵢ₋₂::uType
  Sᵢ::uType
  tmp::uType
  atmp::uNoUnitsType
  fsalfirst::rateType
  k::rateType
  constantcache::ESERK5ConstantCache
end

function alg_cache(alg::ESERK5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  constantcache = ESERK5ConstantCache(u)
  uᵢ = similar(u)
  uᵢ₋₁ = similar(u)
  uᵢ₋₂ = similar(u)
  Sᵢ   = similar(u)
  tmp = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  fsalfirst = zero(rate_prototype)
  k = zero(rate_prototype)
  ESERK5Cache(u, uprev, uᵢ, uᵢ₋₁, uᵢ₋₂, Sᵢ, tmp, atmp, fsalfirst, k, constantcache)
end

function alg_cache(alg::ESERK5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  ESERK5ConstantCache(u)
end

mutable struct SERK2ConstantCache{T, zType} <: OrdinaryDiffEqConstantCache
  ms::SVector{11, Int}
  zprev::zType
  Bᵢ::Vector{T}
  mdeg::Int
  start::Int
  internal_deg::Int
end

@cache struct SERK2Cache{uType,rateType,uNoUnitsType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  uᵢ₋₁::uType
  uᵢ₋₂::uType
  Sᵢ::uType
  tmp::uType
  atmp::uNoUnitsType
  fsalfirst::rateType
  k::rateType
  constantcache::SERK2ConstantCache
end

function alg_cache(alg::SERK2,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  constantcache = SERK2ConstantCache(u)
  uᵢ₋₁ = similar(u)
  uᵢ₋₂ = similar(u)
  Sᵢ   = similar(u)
  tmp = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  fsalfirst = zero(rate_prototype)
  k = zero(rate_prototype)
  SERK2Cache(u, uprev, uᵢ₋₁, uᵢ₋₂, Sᵢ, tmp, atmp, fsalfirst, k, constantcache)
end

function alg_cache(alg::SERK2,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  SERK2ConstantCache(u)
end
