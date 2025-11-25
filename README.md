# QAP-using-Simulated-Annealing-optimized-for-GPU

A high-performance GPU implementation of Simulated Annealing for solving the Quadratic Assignment Problem (QAP) through Ising model formulation using CuPy.

## Requirements
```bash
pip install numpy cupy-cuda11x pandas
```

**Note**: Replace `cupy-cuda11x` with your CUDA version (e.g., `cupy-cuda12x` for CUDA 12.x).

## Usage
```python
from qap_solver import solve_ising_with_qap_check

problem_number = 12

J_filepath = f"QAP_J_h/J_tiny{problem_number:02d}.csv"
h_filepath = f"QAP_J_h/h_tiny{problem_number:02d}.csv"

result = solve_ising_with_qap_check(
    J_filepath, 
    h_filepath, 
    problem_number,
    n_runs=100000,
    max_iter=5000 * problem_number**2,
    inverse_initial_temp=5.0,
    cooling_rate=0.95,
    inverse_final_temp=1000.0
)

print(f"Final QAP Energy: {result['qap_energy']:.2f}")
print(f"Time to 95% convergence: {result['convergence_time']:.4f}s")
```

## Parameters

- `n_runs`: Number of parallel simulated annealing runs
- `max_iter`: Maximum iterations per temperature level
- `inverse_initial_temp`: Initial inverse temperature β
- `cooling_rate`: Temperature decay rate
- `inverse_final_temp`: Final inverse temperature β

## Mathematical Formulation

### Ising Model Energy

$$E = \sum_{i<j} J_{ij} s_i s_j + \sum_i h_i s_i$$

where $$s_i \in {-1, +1}$$ are spin variables.

### QAP Cost Function

$$\text{Cost} = \sum_{i=1}^{n} \sum_{j=1}^{n} F_{ij} \cdot D_{\pi(i)\pi(j)}$$

where $F$ is the flow matrix and $D$ is the distance matrix.
