

#univariate normal kernel
# function GaussianKernel{T<:FloatingPoint}(xeval::T, xi::T, h::T)
#   if h <= 0.0
#     return Inf
#   end
#   exp(-0.5*abs2((xeval - xi)/h)) / h * invsqrt2pi
# end


gkernel{T<:FloatingPoint}(xi::T, xeval::T, h::T)=exp(-0.5*abs2((xeval - xi)/h)) / h * invsqrt2pi
gkernel{T<:Real}(xi::T, xeval::T, h::T) = gkernel(float(xi), float(xeval),float(h))
gkernel(xi::Real, xeval::Real, h::Real)=gkernel(promote(xi, xeval, h)...)
type Gkernel <: Functor{3} end
NumericExtensions.evaluate(::Gkernel, xi, xeval, h) = gkernel(xi, xeval, h)

function ekernel{T<:FloatingPoint}(xi::T, xeval::T, h::T)
    u=(xeval - xi) / h
    abs(u)>=1.0 ? 0.0 : 0.75*(1-u*u)
end
ekernel{T<:Real}(xi::T,xeval::T, h::T) = ekernel(float(xi),float(xeval), float(h))
ekernel(xi::Real, xeval::Real, h::Real)=ekernel(promote(xi, xeval, h)...)
type Ekernel <: Functor{3} end
NumericExtensions.evaluate(::Ekernel, xi, xeval, h) = ekernel(xi, xeval, h)


# #MultiVariate Normal Kernel
# function GaussianKernel(xeval::Vector{Float64}, xi::Vector{Float64}, h::Vector{Float64})
#   if any(h .<= 0.0)
#     return Inf
#   end
#   p=length(xi)

#   exp(-sumsq((xeval .- xi) ./ h)) / (2*pi)^(p/2) / prod(h)

# end
# # GaussianKernel2(xdiff::Float64, h::Float64) = GaussianKernel(xdiff, 0.0, sqrt(2)*h)
# # GaussianKernel2(xdiff::Vector{Float64}, h::Vector{Float64}) = GaussianKernel(xdiff, zeros(length(xdiff)), sqrt(2).* h)

# # Gaussian=KernelType(GaussianKernel, GaussianKernel2)

# function EKernel(xeval::Float64, xi::Float64,h::Float64)
#     if h <= 0.0
#       return Inf
#     end
#     u=(xeval - xi) / h
#     if abs(u) > 1.0
#         return 0.0
#     end
#     return (1.0-u*u)*3.0/4.0
# end


# function EKernel(xeval::Vector{Float64}, xi::Vector{Float64}, h::Vector{Float64})

#     if any(h .<= 0.0)
#         return Inf
#     end
#     p=length(xi)
#     tmp=1.0
#     for i in 1:p
#         tmp *= EKernel(xeval[i],xi[i],h[i])
#     end
#     tmp
# end

# function EKernel2(xdiff::Float64, h::Float64)
#     ax=abs(xdiff / h)
#     if ax > 2.0
#         return 0.0
#     end

#     (2 - ax)^3*(ax^2+6*ax+4) * 3 / 160 / h

# end
# function EKernel2(xdiff::Vector{Float64}, h::Vector{Float64})
#     ax=abs(xdiff ./ h)
#     if any(ax .> 2.0)
#         return 0.0
#     end
#     p=length(ax)
#     tmp=1.0
#     for i in 1:p
#         tmp *= EKernel2(ax[i], h[i])
#     end
#     tmp
# end
# Epanechnikov=KernelType(EKernel, EKernel2)


