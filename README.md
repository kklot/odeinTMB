## odeint in TMB

Barebone templates for implementing ODE models in TMB. Mainly to avoid `Type`
and `double` conflicts. 

Steps:

1. Define the system using example from the class `harm_osc`, the model must be able to initialize when taking the parameter vector as input.
2. Call the model with the class `ODE<Type, model<Type> >` and initialise it with
   1. initial conditions (e.g., `DATA_VECTOR`)
   2. parameters (e.g., `PARAMETER_VECTOR`)
   3. `tmax`: max time of the ODE
   4. `dt`: time steps

Data is store simply as member

- `.track`: a TMB (Eigen) vector, which can be easily reshaped, mapped to other
purposed.
- The system solutions and time steps can be retreived with `out()` method.