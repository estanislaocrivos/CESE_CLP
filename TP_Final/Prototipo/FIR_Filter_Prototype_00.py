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
from scipy.signal import freqz 

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
    x = np.cos(2 * np.pi * f * t)

    for i in range(5):
        f_actual = 35000 + (i * 1000)  # Incrementa la frecuencia en pasos de 1000 Hz
        x = x + np.cos(2 * np.pi * f_actual * t)

    # Add noise
    # x = x + np.random.normal(0, 0.5, N)

    return x

# ---------------------------------------------------------------------------------------------- #

# This function computes the coefficients of a low-pass windowed-sinc (blackman window) filter.
def filter_response(f_cutoff, M):

    # Parameters:
    # f_cutoff: Cutoff frequency as a fraction of the sampling rate.
    # N: Filter length, must be odd.

    # Compute sinc filter.
    h = np.sinc(2 * f_cutoff * (np.arange(M) - (M - 1) / 2))

    # Apply window.
    h = h * np.blackman(M)

    # Normalize to get unity gain.
    h = h / np.sum(h)

    return h

# ---------------------------------------------------------------------------------------------- #

def plot_fir_response(h, f_sampling):
    # Calcula la respuesta en frecuencia del filtro FIR
    w, mag_response = freqz(h)

    # Calcula la magnitud en dB
    mag_response_db = 20 * np.log10(np.abs(mag_response))

    # Calcula la fase en grados
    phase_response_deg = np.angle(mag_response, deg=True)

    # Convierte la frecuencia de radianes a Hertz
    freq_hz = w * f_sampling / (2 * np.pi)

    # Grafica la magnitud de la respuesta en frecuencia
    plt.figure()
    plt.subplot(2, 1, 1)
    plt.plot(freq_hz, mag_response_db)
    plt.title('Magnitude Response', fontsize=12)
    plt.ylabel('Magnitude [dB]', fontsize=10)
    plt.xlabel('Frequency [Hz]', fontsize=10)
    plt.xlim([0, 5*f_cutoff]) # Set x-axis limits
    plt.grid()

    # Grafica la fase de la respuesta en frecuencia
    plt.subplot(2, 1, 2)
    plt.plot(freq_hz, phase_response_deg)
    plt.title('Phase Response', fontsize=12)
    plt.ylabel('Phase [degrees]', fontsize=10)
    plt.xlabel('Frequency [Hz]', fontsize=10)
    plt.xlim([0, 5*f_cutoff]) # Set x-axis limits
    plt.grid()

    # Adjust subplots layout
    plt.subplots_adjust(hspace=0.5)

    # Save plot as .png file and display it
    plt.savefig('Plots/P00_Plot_01.png', dpi=300) # Save plot as .png file

    # Grafica la magnitud de la respuesta en frecuencia sola
    plt.figure()
    plt.plot(freq_hz, mag_response_db)
    plt.title('Magnitude Response', fontsize=12)
    plt.ylabel('Magnitude [dB]', fontsize=10)
    plt.xlabel('Frequency [Hz]', fontsize=10)
    plt.xlim([0, 5*f_cutoff]) # Set x-axis limits
    plt.grid()

    # Save plot as .png file and display it
    plt.savefig('Plots/P00_Plot_02.png', dpi=300) # Save plot as .png file
 
# ---------------------------------------------------------------------------------------------- #

def plot_input_output(x,y):
    # PLot the signal.
    plt.figure()

    plt.figure(figsize=(8, 6))

    # Plot x and y in two subplots:
    plt.subplot(2, 1, 1)
    plt.plot(np.linspace(0, N, N), x, color='#1f77b4')  # Plot x
    plt.title('Filter\'s Input Signal', fontsize=12)  # Set title and font size
    plt.xlabel('Samples', fontsize=10)  # Set x-axis label and font size
    plt.ylabel('Amplitude [V]', fontsize=10)  # Set y-axis label and font size
    plt.xlim([0, 400]) # Set x-axis limits
    plt.ylim([-6, 6])  # Set y-axis limits
    plt.yticks(np.arange(-6, 6, 2))  # Cambia el paso según tus necesidades
    plt.grid() # Enable grid

    plt.subplot(2, 1, 2)
    plt.plot(np.linspace(0, N, N), y, color='#ff7f0e') # Plot y
    plt.title('Filter\'s Output Signal', fontsize=12)  # Set title and font size
    plt.xlabel('Samples', fontsize=10)  # Set x-axis label and font size
    plt.ylabel('Amplitude [V]', fontsize=10)  # Set y-axis label and font size
    plt.xlim([0, 400]) # Set x-axis limits
    plt.ylim([-6, 6])  # Set y-axis limits
    plt.yticks(np.arange(-6, 6, 2))  # Cambia el paso según tus necesidades
    plt.grid() # Enable grid

    # Adjust subplots layout
    plt.subplots_adjust(hspace=0.5)

    # Save plot as .png file and display it
    plt.savefig('Plots/P00_Plot_00.png', dpi=300) # Save plot as .png file

# ---------------------------------------------------------------------------------------------- #

# COMPUTE FILTER RESPONSE WITH RANDOM INPUT SIGNAL

# ---------------------------------------------------------------------------------------------- #

N = 1001 # Signal length.
M = 13 # Filter length.
f = 5000 # Signal frequency.
f_sampling = 100000 # Sampling frequency.
f_cutoff = 10000 # Cutoff frequency 

# Generate filter coefficients.
h = filter_response(f_cutoff/f_sampling, M)
# h = np.array([0, 0.02, 0.1, 0.23, 0.3, 0.23, 0.1, 0.02, 0])*100
sum_coefficients = np.sum(h)
print(h)

# Generate input signal.
x = input_signal(f, f_sampling, N)

# Initialize output signal.
y = np.zeros_like(x)

for i in range(M, N):
    # Convolve filter with signal.
    y[i] = np.sum(h * x[i-M+1:i+1])

# y = y/sum_coefficients
# h = h/100

plot_input_output(x,y)

plot_fir_response(h, f_sampling)

# ---------------------------------------------------------------------------------------------- #


