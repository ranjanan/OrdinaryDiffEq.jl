# This definitely needs cleaning
using OrdinaryDiffEq, DiffEqDevTools, Test, Random
using DiffEqProblemLibrary.ODEProblemLibrary: importodeproblems; importodeproblems()
import DiffEqProblemLibrary.ODEProblemLibrary: prob_ode_linear, prob_ode_2Dlinear
probArr = Vector{ODEProblem}(undef, 2)
probArr[1] = prob_ode_linear

probArr[2] = prob_ode_2Dlinear
Random.seed!(100)
## Convergence Testing
dts = 1 .//2 .^(8:-1:4)
dts1 = 1 .//2 .^(9:-1:5)
dts2 = 1 .//2 .^(7:-1:3)
dts3 = 1 .//2 .^(12:-1:7)
testTol = 0.2

for i = 1:2
  global dts
  prob = probArr[i]
  sim = test_convergence(dts,prob,Euler())
  @test sim.𝒪est[:final] ≈ 1 atol=testTol
  sim2 = test_convergence(dts,prob,Heun())
  @test sim2.𝒪est[:l∞] ≈ 2 atol=testTol
  sim2 = test_convergence(dts,prob,Ralston())
  @test sim2.𝒪est[:l∞] ≈ 2 atol=testTol
  sim2 = test_convergence(dts,prob,Midpoint())
  @test sim2.𝒪est[:l∞] ≈ 2 atol=testTol
  sim3 = test_convergence(dts,prob,RK4())
  @test sim3.𝒪est[:l∞] ≈ 4 atol=testTol

  sim3 = test_convergence(dts2,prob,KuttaPRK2p5(threading=true))
  @test sim3.𝒪est[:l∞] ≈ 5 atol=testTol

  sim3 = test_convergence(dts2,prob,KuttaPRK2p5(threading=false))
  @test sim3.𝒪est[:l∞] ≈ 5 atol=testTol

  sim4 = test_convergence(dts,prob,BS3())
  @test sim4.𝒪est[:l2] ≈ 3 atol=testTol
  sim5 = test_convergence(dts, prob, AB3())
  @test sim5.𝒪est[:l2] ≈ 3 atol=testTol
  sim6 = test_convergence(dts,prob,ABM32())
  @test sim6.𝒪est[:l2] ≈ 3 atol=testTol
  sim7 = test_convergence(dts, prob, AB4())
  @test sim7.𝒪est[:l2] ≈ 4 atol=testTol
  sim8 = test_convergence(dts1,prob,ABM43())  #using dts1 due to floating point error in convergence test
  @test sim8.𝒪est[:l2] ≈ 4 atol=testTol
  sim9 = test_convergence(dts,prob,AB5())
  @test sim9.𝒪est[:l2] ≈ 5 atol=testTol
  sim10 = test_convergence(dts,prob,ABM54())
  @test sim10.𝒪est[:l2] ≈ 5 atol=testTol
  sim101 = test_convergence(dts,prob,VCAB3())
  @test sim101.𝒪est[:l2] ≈ 3 atol=testTol
  sim102 = test_convergence(dts,prob,VCAB4())
  @test sim102.𝒪est[:l2] ≈ 4 atol=testTol
  sim103 = test_convergence(dts,prob,VCAB5())
  @test sim103.𝒪est[:l2] ≈ 5 atol=testTol
  sim104 = test_convergence(dts,prob,VCABM3())
  @test sim104.𝒪est[:l2] ≈ 3 atol=testTol
  sim105 = test_convergence(dts,prob,VCABM4())
  @test sim105.𝒪est[:l2] ≈ 4 atol=testTol
  sim106 = test_convergence(dts,prob,VCABM5())
  @test sim106.𝒪est[:l2] ≈ 5 atol=testTol
  sim160 = test_convergence(dts,prob,Anas5(w=2))
  @test sim160.𝒪est[:l2] ≈ 4 atol=2*testTol

  println("Stiff Solvers")

  dts = 1 .//2 .^(9:-1:5)

  sim11 = test_convergence(dts,prob,ImplicitEuler(extrapolant = :linear))
  @test sim11.𝒪est[:final] ≈ 1 atol=testTol

  sim112 = test_convergence(dts,prob,ImplicitEuler(nlsolve = NLFunctional()),reltol=1e-2)
  @test sim112.𝒪est[:final] ≈ 1 atol=testTol

  sim113 = test_convergence(dts,prob,ImplicitEuler(nlsolve = NLAnderson()),reltol=1e-2)
  @test sim113.𝒪est[:final] ≈ 1 atol=testTol

  sim12 = test_convergence(dts,prob,
          GenericImplicitEuler(nlsolve=OrdinaryDiffEq.NLSOLVEJL_SETUP(autodiff=true)))
  @test sim12.𝒪est[:final] ≈ 1 atol=testTol

  sim122 = test_convergence(dts,prob,
           GenericImplicitEuler(nlsolve=OrdinaryDiffEq.NLSOLVEJL_SETUP(autodiff=false)))

  sim13 = test_convergence(dts,prob,ImplicitMidpoint())
  @test sim13.𝒪est[:final] ≈ 2 atol=testTol

  sim132 = test_convergence(dts,prob,ImplicitMidpoint(nlsolve = NLFunctional()))
  @test sim132.𝒪est[:final] ≈ 2 atol=testTol

  sim134 = test_convergence(dts,prob,ImplicitMidpoint(nlsolve = NLAnderson()))
  @test sim134.𝒪est[:final] ≈ 2 atol=testTol

  sim13 = test_convergence(dts,prob,Trapezoid())
  @test sim13.𝒪est[:final] ≈ 2 atol=testTol

  sim133 = test_convergence(dts,prob,Trapezoid(nlsolve = NLFunctional()))
  @test sim133.𝒪est[:final] ≈ 2 atol=testTol

  sim135 = test_convergence(dts,prob,Trapezoid(nlsolve = NLAnderson()))
  @test sim135.𝒪est[:final] ≈ 2 atol=testTol

  sim14 = test_convergence(dts,prob,
          GenericTrapezoid(nlsolve=OrdinaryDiffEq.NLSOLVEJL_SETUP(autodiff=true)))
  @test sim14.𝒪est[:final] ≈ 2 atol=testTol

  sim142 = test_convergence(dts,prob,
           GenericTrapezoid(nlsolve=OrdinaryDiffEq.NLSOLVEJL_SETUP(autodiff=false)))
  @test sim142.𝒪est[:final] ≈ 2 atol=testTol

  sim14 = test_convergence(dts,prob,TRBDF2())
  @test sim14.𝒪est[:final] ≈ 2 atol=testTol

  sim152 = test_convergence(dts,prob,TRBDF2(autodiff=false))
  @test sim152.𝒪est[:final] ≈ 2 atol=testTol+0.1

  sim15 = test_convergence(dts,prob,SDIRK2())
  @test sim15.𝒪est[:final] ≈ 2 atol=testTol

  sim152 = test_convergence(dts,prob,SSPSDIRK2())
  @test sim152.𝒪est[:final] ≈ 2 atol=testTol

  sim16 = test_convergence(dts,prob,Kvaerno3())
  @test sim16.𝒪est[:final] ≈ 3 atol=testTol

  sim162 = test_convergence(dts,prob,Kvaerno3(nlsolve = NLFunctional()))
  @test sim162.𝒪est[:final] ≈ 3 atol=testTol

  sim17 = test_convergence(dts,prob,KenCarp3())
  @test sim17.𝒪est[:final] ≈ 3 atol=testTol

  #####################################
  # BDF
  #####################################

  sim = test_convergence(dts3,prob,ABDF2())
  @test sim.𝒪est[:final] ≈ 2 atol=testTol
  @test sim.𝒪est[:l2] ≈ 2 atol=testTol
  @test sim.𝒪est[:l∞] ≈ 2 atol=testTol

  sim = test_convergence(dts,prob,ABDF2(nlsolve = NLFunctional()))
  @test sim.𝒪est[:final] ≈ 2 atol=testTol
  @test sim.𝒪est[:l2] ≈ 2 atol=testTol
  @test sim.𝒪est[:l∞] ≈ 2 atol=testTol

  # QBDF
  sim = test_convergence(dts,prob,QBDF1())
  @test sim.𝒪est[:final] ≈ 1 atol=testTol
  @test sim.𝒪est[:l2] ≈ 1 atol=testTol
  @test sim.𝒪est[:l∞] ≈ 1 atol=testTol

  sim = test_convergence(dts,prob,QBDF2())
  @test sim.𝒪est[:final] ≈ 2 atol=testTol
  @test sim.𝒪est[:l2] ≈ 2 atol=testTol
  @test sim.𝒪est[:l∞] ≈ 2 atol=testTol

  # QNDF
  sim = test_convergence(dts,prob,QNDF1())
  @test sim.𝒪est[:final] ≈ 1 atol=testTol
  @test sim.𝒪est[:l2] ≈ 1 atol=testTol
  @test sim.𝒪est[:l∞] ≈ 1 atol=testTol

  sim = test_convergence(dts3,prob,QNDF2())
  @test sim.𝒪est[:final] ≈ 2 atol=testTol
  @test sim.𝒪est[:l2] ≈ 2 atol=testTol
  @test sim.𝒪est[:l∞] ≈ 2 atol=testTol

  sim = test_convergence(dts,prob,QNDF2(nlsolve = NLFunctional()))
  @test sim.𝒪est[:final] ≈ 2 atol=testTol
  @test sim.𝒪est[:l2] ≈ 2 atol=testTol
  @test sim.𝒪est[:l∞] ≈ 2 atol=testTol
  @test_nowarn solve(prob, QNDF())

  # MEBDF2
  sim21 = test_convergence(dts,prob,MEBDF2(extrapolant = :linear))
  @test sim21.𝒪est[:final] ≈ 2 atol=testTol

  sim22 = test_convergence(dts,prob,MEBDF2(nlsolve = NLFunctional()),reltol=1e-2)
  @test sim22.𝒪est[:final] ≈ 2 atol=testTol

  sim23 = test_convergence(dts,prob,MEBDF2(nlsolve = NLAnderson()),reltol=1e-2)
  @test sim23.𝒪est[:final] ≈ 2 atol=testTol

  dts = 1 .//2 .^(7:-1:4)
  println("Higher Order")

  sim18 = test_convergence(dts,prob,Cash4())
  @test sim18.𝒪est[:final] ≈ 4 atol=testTol

  sim19 = test_convergence(dts,prob,Hairer4())
  @test sim19.𝒪est[:final] ≈ 4 atol=testTol

  sim20 = test_convergence(dts,prob,RK46NL())
  @test sim20.𝒪est[:final] ≈ 4 atol=testTol
  @test sim20.𝒪est[:l2] ≈ 4 atol=testTol
  @test sim20.𝒪est[:l∞] ≈ 4 atol=testTol

  sim110 = test_convergence(dts,prob,Hairer42())
  @test sim110.𝒪est[:final] ≈ 4 atol=testTol

  sim111 = test_convergence(dts,prob,Kvaerno4())
  @test sim111.𝒪est[:final] ≈ 4 atol=testTol

  sim112 = test_convergence(dts,prob,KenCarp4())
  @test sim112.𝒪est[:final] ≈ 4 atol=testTol

  sim113 = test_convergence(dts,prob,Kvaerno5())
  @test sim113.𝒪est[:final] ≈ 5 atol=testTol

  sim114 = test_convergence(dts,prob,KenCarp5())
  @test sim114.𝒪est[:final] ≈ 5 atol=testTol

  sim115 = test_convergence(dts,prob,KenCarp5(nlsolve = NLFunctional()))
  @test_broken sim115.𝒪est[:final] ≈ 5 atol=testTol

  sim116 = test_convergence(dts,prob,ESDIRK54I8L2SA())
  @test sim116.𝒪est[:final] ≈ 5 atol=testTol
end
