import pandas as pd
import matplotlib.pyplot as plt

# Cargar los resultados del Mac M2
m2_data = pd.read_csv('./benchmark_results_M2.csv')

# Datos del Mac Pro (hardcoded según los datos anteriores del usuario)
mac_pro_data = pd.DataFrame({
    'Procesos': [1, 2, 4, 6, 8, 12],
    'TotalOps': [20, 40, 80, 120, 160, 240],
    'TiempoTotal': [1.011, 1.009, 1.013, 1.016, 1.020, 2.027],
    'TiempoPorOp': [0.05054, 0.02522, 0.01266, 0.00847, 0.00637, 0.00844]
})

# Graficar tiempo por operación
plt.figure(figsize=(10, 6))
plt.plot(mac_pro_data['Procesos'], mac_pro_data['TiempoPorOp'], marker='o', label='Mac Pro 2013')
plt.plot(m2_data['Procesos'], m2_data['TiempoPorOp'], marker='s', label='Mac M2')
plt.title("Comparación de rendimiento paralelo (Tiempo por operación)")
plt.xlabel("Número de procesos")
plt.ylabel("Tiempo por operación (s)")
plt.grid(True)
plt.legend()
plt.tight_layout()
plt.show()

