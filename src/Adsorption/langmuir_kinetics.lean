import data.real.basic

/-!
# Langmuir adsorption model
This section defines Langmuir adsorption model from kinetics for a single adsorbate on a single site: <br>
$$
θ = \frac{K Pₐ}{1  +  K Pₐ} 
$$
where:
- `θ` is the fractional occupancy of the adsorption sites
- `K` is the adsorption constant describing the adsorption/desorption rates in equilibrium
- `Pₐ` is the partial pressure of the adsorbate

### Assumption
The model assumes the rate of adsorption `r_ad = k_ad * Pₐ * S` and <br> 
the rate of desorption `r_d = k_d * A` are equal at equilibrium conditions where:
- `k_ad` is the adsorption constant
- `k_d` is the desorption constant
-  `S` is the concentartion of all sites
- `A` is the concentartion of occupied sites

### Constraints generated by Lean
- `S ≠ 0`
- `k_d ≠ 0`


### To-Do
- Proof statistical mechanical derivation of the model
- Generalize proof from properties of system
-/

theorem Langmuir_single_site
(Pₐ k_ad k_d A S : ℝ)
(hreaction : let r_ad := k_ad*Pₐ*S, r_d := k_d*A in r_ad = r_d) 
(hS : S ≠ 0)
(hk_d : k_d ≠ 0)
: 
let θ := A/(S+A),
    K := k_ad/k_d in 
θ = K*Pₐ/(1+K*Pₐ) :=
begin
  simp at hreaction,
  rw [mul_comm k_d A, ← div_eq_div_iff hk_d hS] at hreaction,
  field_simp [hreaction],
end

