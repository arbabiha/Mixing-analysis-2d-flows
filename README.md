# Mixing-analysis-2d-flows
Mix-norm and hypergraphs for study of mixing in 2d flows
These tools are used in "Spectral analysis of mixing in  2D high-Reynolds flows" by H. Arbabi and I. Mezic.



## Hypergraphs
Hypergraph is an efficient tool for qualitative assesment of mixing.  For the mathematical definition and computation steps see the above paper.
By looking at hypergraph one can delineate the flow regions where chaotic mixing occurs (grainy mixture of red and blue) from places of regular motion and no or slow mixing (coherent blobs and circles). Unlike classical tools like Poincare maps, hypergraphs also work for aperiodic flows.

<img src="../master/thehood/Poincare_vs_Hypergraphs.png" width="750">

Hypergraph techqniue was introduced by Mezic et al, 2010, "A new mixing diagnostic and the gulf oil spill", Science.


## Mix-norm 
Mix-norm is a measure of how "mixed" a density field is. Technically speaking, it is a function norm specially suited to study of advective mixing. Its essential feature is that it puts more weight on large spatial features. For example, the below figure shows how a blob of material is being advected in a time-dependent flow in a box. The large blob in some places is being strectched into smaller filaments and hence the mix-norm of the density field decreases with time. See the "./thehood/SobolevNorm2D" for detail.

<img src="../master/thehood/Mixnorm_example.png" width="750">

The mix-norm was introduced in Mathew et al, 2005, "A multiscale measure for mixing", Physica D.

## files in the root folder

* Hypergraph_demo: we do ...

* Mix_norm_demo: this program performs semil-Lagrangian advection of a square blob in periodic cavity flow (Re=13000) and computes the mix-norm of density field in time.   


## flow data for the paper

All the above code are done for the steady flow at Re=1000 in cavity flow. For computing the figures in the paper you need the data corresponding to the flow







Send comments and questions to arbabiha-AT-gmail.com

H. Arbabi


February 2019
