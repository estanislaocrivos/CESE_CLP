'''

CESE CO20 - CLP [Trabajo Final]

Author: Estanislao Crivos
Date: April 2024

This file implements a simple FIR filter prototype. The filter is a low-pass windowed-sinc 
(blackman window) filter. An example input signal with added white noise is computed to test the 
filter response.

'''

from __future__ import print_function
from __future__ import division

import numpy as np
import matplotlib.pyplot as plt

# Use LaTeX font for all text
plt.rcParams.update({
    "text.usetex": True,
    "font.family": "serif",
    "font.serif": ["Computer Modern Roman"]
})

# ---------------------------------------------------------------------------------------------- #

# This function generates a simple input signal.
def input_signal(f, f_sampling, N):

    #Parameters:
    # N: Number of samples
    # f: Signal frequency
    # f_sampling: Sampling frequency
    
    A = 1 # Signal amplitude

    # Time vector
    t = np.linspace(0, (N-1)/f_sampling, N)

    # Signal
    x = A*np.sin(2*np.pi*f*t) + A*np.sin(2*np.pi*(500)*t) + A*np.sin(2*np.pi*(1000)*t) + A*np.sin(2*np.pi*(2000)*t)

    # x = np.zeros(N)

    # for i in range(0, 4):
        # x = x + A*np.sin(2*np.pi*(f*(10**i))*t)

    # Add noise
    x = x + np.random.normal(0, 0.5, N)

    return x

# ---------------------------------------------------------------------------------------------- #

# This function computes the coefficients of a low-pass windowed-sinc (blackman window) filter.
def filter_response(f_cutoff, M):

    # Parameters:
    # f_cutoff: Cutoff frequency as a fraction of the sampling rate.
    # N: Filter length, must be odd.

    # Compute sinc filter.
    # h = np.sin(2 * np.pi * f_cutoff * (np.arange(M) - (M - 1) / 2)) / (np.arange(M) - (M - 1) / 2)
    h = np.sinc(2 * f_cutoff * (np.arange(M) - (M - 1) / 2))

    # Apply window.
    h = h * np.blackman(M)

    # Normalize to get unity gain.
    h = h / np.sum(h)

    return h

# ---------------------------------------------------------------------------------------------- #

# COMPUTE FILTER IMPULSE RESPONSE

# ---------------------------------------------------------------------------------------------- #

N = 1001 # Signal length.
M = 201 # Filter length.
f = 50 # Signal frequency.
f_sampling = 4000 # Sampling frequency.
f_cutoff = 100/f_sampling; # Cutoff frequency as a fraction of the sampling rate.

# Generate filter coefficients.
h = filter_response(f_cutoff, M)

# Generate input signal.
x = np.zeros(N)

x[100:] = 1

# Initialize output signal.
y = np.zeros_like(x)

for i in range(M, N):
    # Convolve filter with signal.
    y[i] = np.sum(h * x[i-M+1:i+1])

# ---------------------------------------------------------------------------------------------- #

# PLot the signal.
plt.figure()

plt.figure(figsize=(8, 6))

plt.plot(np.linspace(0, N, N), y, color='#1f77b4')  # Plot x
plt.title('Filter\'s Impulse Response', fontsize=12)  # Set title and font size
plt.xlabel('Samples', fontsize=10)  # Set x-axis label and font size
plt.ylabel('Amplitude', fontsize=10)  # Set y-axis label and font size
plt.xlim([0, N]) # Set x-axis limits
plt.ylim([-0.5, 1.5])  # Set y-axis limits
plt.grid(True) # Enable grid

# Save plot as .png file and display it
plt.savefig('Plots/Impulse_Response.png', dpi=300) # Save plot as .png file
# plt.show()

print(y)

# ---------------------------------------------------------------------------------------------- #