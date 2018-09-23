fl32 /W0 /nologo start_diff.for bc\id.for bc\upinitial.for
fl32 /W0 /nologo start_conv.for bc\id.for
fl32 /W0 /nologo start_solid.for

fl32 /W0 /nologo interpolation.for
fl32 /W0 /nologo interpolate.for
fl32 /W0 /nologo updatecoor.for
fl32 /W0 /nologo bft.for bc\bound.for

fl32 /W0 /nologo preconditioner.for lib\ceq9g3.for lib\cec27g3.for lib\ccshap.for lib\shap.for
fl32 /W0 /nologo pressure.for lib\feq9g3.for lib\fec27g3.for lib\ccshap.for lib\shap.for

fl32 /W0 /nologo convection.for lib\beq9g3.for lib\bec27g3.for lib\ccshap.for lib\shap.for
fl32 /W0 /nologo diffusion.for lib\aeq9g3.for lib\aec27g3.for lib\ccshap.for lib\shap.for
fl32 /W0 /nologo solid.for lib\det3.for lib\dew4.for lib\ccshap.for lib\shap.for
fl32 /W0 /nologo cauchystress.for lib\eet3.for lib\eew4.for lib\ccshap.for lib\shap.for

