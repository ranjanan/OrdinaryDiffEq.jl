immutable ROS3PConstantCache{T,T2} <: OrdinaryDiffEqConstantCache
  a21::T
  a31::T
  a32::T
  C21::T
  C31::T
  C32::T
  b1::T
  b2::T
  b3::T
  btilde1::T
  btilde2::T
  btilde3::T
  gamma::T2
  c2::T2
  c3::T2
  d1::T
  d2::T
  d3::T
end

function ROS3PConstantCache(T::Type,T2::Type)
  gamma = T(1/2 + sqrt(3)/6)
  igamma = inv(gamma)
  a21 = T(igamma)
  a31 = T(igamma)
  a32 = T(0)
  C21 = T(-igamma^2)
  tmp = -igamma*(2 - (1/2)*igamma)
  C31 = -igamma*(1-tmp)
  C32 = tmp
  tmp = igamma*(2/3 - (1/6)*igamma)
  b1 = igamma*(1+tmp)
  b2 = tmp
  b3 = (1/3)*igamma
  btilde1 = T(2.113248654051871)
  btilde2 = T(1.000000000000000)
  btilde3 = T(0.4226497308103742)
  c2 = T(1)
  c3 = T(1)
  d1 = T(0.7886751345948129)
  d2 = T(-0.2113248654051871)
  d3 = T(-1.077350269189626)
  ROS3PConstantCache(a21,a31,a32,C21,C31,C32,b1,b2,b3,btilde1,btilde2,btilde3,gamma,c2,c3,d1,d2,d3)
end

immutable Rodas3ConstantCache{T,T2} <: OrdinaryDiffEqConstantCache
  a21::T
  a31::T
  a32::T
  a41::T
  a42::T
  a43::T
  C21::T
  C31::T
  C32::T
  C41::T
  C42::T
  C43::T
  b1::T
  b2::T
  b3::T
  b4::T
  btilde1::T
  btilde2::T
  btilde3::T
  btilde4::T
  gamma::T2
  c2::T2
  c3::T2
  d1::T
  d2::T
  d3::T
  d4::T
end

function Rodas3ConstantCache(T::Type,T2::Type)
  gamma = T(1//2)
  a21 = T(0)
  a31 = T(2)
  a32 = T(0)
  a41 = T(2)
  a42 = T(0)
  a43 = T(1)
  C21 = T(4)
  C31 = T(1)
  C32 = T(-1)
  C41 = T(1)
  C42 = T(-1)
  C43 = T(-8//3)
  b1 = T(2)
  b2 = T(0)
  b3 = T(1)
  b4 = T(1)
  btilde1 = T(0.0)
  btilde2 = T(0.0)
  btilde3 = T(0.0)
  btilde4 = T(1.0)
  c2 = T(0.0)
  c3 = T(1.0)
  c4 = T(1.0)
  d1 = T(1//2)
  d2 = T(3//2)
  d3 = T(0)
  d4 = T(0)
  Rodas3ConstantCache(a21,a31,a32,a41,a42,a43,C21,C31,C32,C41,C42,C43,b1,b2,b3,b4,btilde1,btilde2,btilde3,btilde4,gamma,c2,c3,d1,d2,d3,d4)
end

immutable Ros4ConstantCache{T,T2} <: OrdinaryDiffEqConstantCache
  a21::T
  a31::T
  a32::T
  C21::T
  C31::T
  C32::T
  C41::T
  C42::T
  C43::T
  b1::T
  b2::T
  b3::T
  b4::T
  btilde1::T
  btilde2::T
  btilde3::T
  btilde4::T
  gamma::T2
  c2::T2
  c3::T2
  d1::T
  d2::T
  d3::T
  d4::T
end

function RosShamp4ConstantCache(T::Type,T2::Type)
  a21=T(2)
  a31=T(48//25)
  a32=T(6//25)
  C21=T(-8)
  C31=T(372//25)
  C32=T(12//5)
  C41=T(-112//125)
  C42=T(-54//125)
  C43=T(-2//5)
  b1=T(19//9)
  b2=T(1//2)
  b3=T(25//108)
  b4=T(125//108)
  btilde1=T(17//54)
  btilde2=T(7//36)
  btilde3=T(0)
  btilde4=T(125//108)
  gamma=T2(1//2)
  c2= T2(1)
  c3= T2(3//5)
  d1=T( 1//2)
  d2=T(-3//2)
  d3=T( 2.42)
  d4=T( 0.116)
  Ros4ConstantCache(a21,a31,a32,C21,C31,C32,C41,C42,C43,b1,b2,b3,b4,btilde1,btilde2,btilde3,btilde4,gamma,c2,c3,d1,d2,d3,d4)
end

function Veldd4ConstantCache(T::Type,T2::Type)
  a21= T(2.000000000000000)
  a31= T(4.812234362695436)
  a32= T(4.578146956747842)
  C21=-T(5.333333333333331)
  C31= T(6.100529678848254)
  C32= T(1.804736797378427)
  C41=-T(2.540515456634749)
  C42=-T(9.443746328915205)
  C43=-T(1.988471753215993)
  b1= T(4.289339254654537)
  b2= T(5.036098482851414)
  b3= T(0.6085736420673917)
  b4= T(1.355958941201148)
  btilde1= T(2.175672787531755)
  btilde2= T(2.950911222575741)
  btilde3=-T(.7859744544887430)
  btilde4=-T(1.355958941201148)
  gamma= T2(0.2257081148225682)
  c2= T2(0.4514162296451364)
  c3= T2(0.8755928946018455)
  d1= T(0.2257081148225682)
  d2=-T(0.04599403502680582)
  d3= T(0.5177590504944076)
  d4=-T(0.03805623938054428)
  Ros4ConstantCache(a21,a31,a32,C21,C31,C32,C41,C42,C43,b1,b2,b3,b4,btilde1,btilde2,btilde3,btilde4,gamma,c2,c3,d1,d2,d3,d4)
end

function Velds4ConstantCache(T::Type,T2::Type)
  a21= T(2)
  a31= T(7//4)
  a32= T(1//4)
  C21=-T(8)
  C31=-T(8)
  C32=-T(1)
  C41= T(1//2)
  C42=-T(1//2)
  C43= T(2)
  b1= T(4//3)
  b2= T(2//3)
  b3=-T(4//3)
  b4= T(4//3)
  btilde1=-T(1//3)
  btilde2=-T(1//3)
  btilde3=-T(0)
  btilde4=-T(4//3)
  gamma= T2(1//2)
  c2= T2(1)
  c3= T2(1//2)
  d1= T(1//2)
  d2=-T(3//2)
  d3=-T(3//4)
  d4= T(1//4)
  Ros4ConstantCache(a21,a31,a32,C21,C31,C32,C41,C42,C43,b1,b2,b3,b4,btilde1,btilde2,btilde3,btilde4,gamma,c2,c3,d1,d2,d3,d4)
end

function GRK4TConstantCache(T::Type,T2::Type)
  a21= T(2)
  a31= T(4.524708207373116)
  a32= T(4.163528788597648)
  C21=-T(5.071675338776316)
  C31= T(6.020152728650786)
  C32= T(0.1597506846727117)
  C41=-T(1.856343618686113)
  C42=-T(8.505380858179826)
  C43=-T(2.084075136023187)
  b1= T(3.957503746640777)
  b2= T(4.624892388363313)
  b3= T(0.6174772638750108)
  b4= T(1.282612945269037)
  btilde1= T(2.302155402932996)
  btilde2= T(3.073634485392623)
  btilde3=-T(0.8732808018045032)
  btilde4=-T(1.282612945269037)
  gamma= T2(0.231)
  c2= T2(0.462)
  c3= T2(0.8802083333333334)
  d1= T(0.2310000000000000)
  d2=-T(0.03962966775244303)
  d3= T(0.5507789395789127)
  d4=-T(0.05535098457052764)
  Ros4ConstantCache(a21,a31,a32,C21,C31,C32,C41,C42,C43,b1,b2,b3,b4,btilde1,btilde2,btilde3,btilde4,gamma,c2,c3,d1,d2,d3,d4)
end

function GRK4AConstantCache(T::Type,T2::Type)
  a21= T(1.108860759493671)
  a31= T(2.377085261983360)
  a32= T(0.1850114988899692)
  C21=-T(4.920188402397641)
  C31= T(1.055588686048583)
  C32= T(3.351817267668938)
  C41= T(3.846869007049313)
  C42= T(3.427109241268180)
  C43=-T(2.162408848753263)
  b1= T(1.845683240405840)
  b2= T(0.1369796894360503)
  b3= T(0.7129097783291559)
  b4= T(0.6329113924050632)
  btilde1= T(0.04831870177201765)
  btilde2=-T(0.6471108651049505)
  btilde3= T(0.2186876660500240)
  btilde4=-T(0.6329113924050632)
  gamma= T2(0.3950000000000000)
  c2= T2(0.4380000000000000)
  c3= T2(0.8700000000000000)
  d1= T(0.3950000000000000)
  d2=-T(0.3726723954840920)
  d3= T(0.06629196544571492)
  d4= T(0.4340946962568634)
  Ros4ConstantCache(a21,a31,a32,C21,C31,C32,C41,C42,C43,b1,b2,b3,b4,btilde1,btilde2,btilde3,btilde4,gamma,c2,c3,d1,d2,d3,d4)
end

function Ros4LStabConstantCache(T::Type,T2::Type)
  a21= T(2.000000000000000)
  a31= T(1.867943637803922)
  a32= T(0.2344449711399156)
  C21=-T(7.137615036412310)
  C31= T(2.580708087951457)
  C32= T(0.6515950076447975)
  C41=-T(2.137148994382534)
  C42=-T(0.3214669691237626)
  C43=-T(0.6949742501781779)
  b1= T(2.255570073418735)
  b2= T(0.2870493262186792)
  b3= T(0.4353179431840180)
  b4= T(1.093502252409163)
  btilde1=-T(0.2815431932141155)
  btilde2=-T(0.07276199124938920)
  btilde3=-T(0.1082196201495311)
  btilde4=-T(1.093502252409163)
  gamma= T2(0.5728200000000000)
  c2= T2(1.145640000000000)
  c3= T2(0.6552168638155900)
  d1= T(0.5728200000000000)
  d2=-T(1.769193891319233)
  d3= T(0.7592633437920482)
  d4=-T(0.1049021087100450)
  Ros4ConstantCache(a21,a31,a32,C21,C31,C32,C41,C42,C43,b1,b2,b3,b4,btilde1,btilde2,btilde3,btilde4,gamma,c2,c3,d1,d2,d3,d4)
end
