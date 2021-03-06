module MultiFEOperators

using Gridap
import Gridap.FEOperators: LinearFEOperator
import Gridap.FEOperators: NonLinearFEOperator

function LinearFEOperator(
  biform::Function,
  liform::Function,
  testfesp::Vector{<:FESpaceWithDirichletData},
  trialfesp::Vector{<:FESpaceWithDirichletData},
  assem::MultiAssembler,
  trian::Triangulation{Z},
  quad::CellQuadrature{Z}) where Z
  V = MultiFESpace(testfesp)
  U = MultiFESpace(trialfesp)
  LinearFEOperator(biform,liform,V,U,assem,trian,quad)
end

function LinearFEOperator(
  testfesp::Vector{<:FESpaceWithDirichletData},
  trialfesp::Vector{<:FESpaceWithDirichletData},
  assem::MultiAssembler,
  terms::Vararg{<:AffineFETerm})

  V = MultiFESpace(testfesp)
  U = MultiFESpace(trialfesp)
  LinearFEOperator(V,U,assem,terms...)
end

function NonLinearFEOperator(
  res::Function,
  jac::Function,
  testfesp::Vector{<:FESpaceWithDirichletData},
  trialfesp::Vector{<:FESpaceWithDirichletData},
  assem::MultiAssembler,
  trian::Triangulation{Z},
  quad::CellQuadrature{Z}) where Z
  V = MultiFESpace(testfesp)
  U = MultiFESpace(trialfesp)
  NonLinearFEOperator(res,jac,V,U,assem,trian,quad)
end

function NonLinearFEOperator(
  testfesp::Vector{<:FESpaceWithDirichletData},
  trialfesp::Vector{<:FESpaceWithDirichletData},
  assem::MultiAssembler,
  terms::Vararg{<:FETerm})

  V = MultiFESpace(testfesp)
  U = MultiFESpace(trialfesp)
  NonLinearFEOperator(V,U,assem,terms...)
end

function NonLinearFEOperator(
  testfesp::Vector{<:FESpaceWithDirichletData},
  trialfesp::Vector{<:FESpaceWithDirichletData},
  terms::Vararg{<:FETerm})

  assem = SparseMatrixAssembler(testfesp,trialfesp)

  V = MultiFESpace(testfesp)
  U = MultiFESpace(trialfesp)
  NonLinearFEOperator(V,U,assem,terms...)
end

end # module MultiFEOperators
