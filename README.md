# Mixing-analysis-2d-flows

Tools for study of mixing in 2d flows used in "Spectral analysis of mixing in  2D high-Reynolds flows" by H. Arbabi and I. Mezic (https://arxiv.org/pdf/1903.10044.pdf).




## Hypergraphs
Hypergraph is an efficient tool for qualitative assesment of advective mixing.  By looking at hypergraph one can delineate the flow regions where there is chaotic mixing (grainy mixture of red and blue) from places with no substantial mixing (coherent blobs and circles). Unlike classical tools like Poincare maps, hypergraphs also work for aperiodic flows and finite-time analysis.


<img src="../master/thehood/Poincare_vs_Hypergraphs.png" width="750">

Hypergraph techqniue was introduced by Mezic et al, 2010, "A new mixing diagnostic and the gulf oil spill", Science.


## Mix-norm 
Mix-norm is a measure of how "mixed" a density field is. Technically speaking, it is a Sobolev-space norm of negative index, but its essential feature is that it puts less weight on smaller spatial features. For example, the below figure shows how a blob of material is being advected in a time-dependent flow in a box. The large blob in some places is being stretched into smaller filaments and hence the mix-norm of the density field decreases with time. See the "./thehood/SobolevNorm2D" for detail.

<img src="../master/thehood/Mixnorm_example.png" width="650">

The mix-norm was introduced in Mathew et al, 2005, "A multiscale measure for mixing", Physica D.

## files in the root folder

* Hypergraph_demo: runs forward advection and variational system for a 100 second in periodic cavity flow (Re=13000), then plots hypergraphs at various times. Simulation time ~150 seconds on my laptop.

* Mix_norm_demo: performs semi-Lagrangian advection of a square blob in periodic cavity flow (Re=13000) and then computes the mix-norm of density field at various times.  It takes ~ 100 seconds on my laptop. 


## flow data for the paper

The flow field data used in the demos is the periodic flow at Re=13000 in the 2D lid-driven cavity. The data for other flows used in the paper are available at https://ucsb.box.com/s/7t44ootww9b3axe3oqyngttokl7f75lr .



Send comments and questions to arbabiha-AT-gmail.com

H. Arbabi


February 2019
