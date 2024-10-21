
#!/bin/bash

# Solicitar datos al usuario usando echo y read
echo "Por favor, introduzca los siguientes datos:"

echo "Nombre del trabajador:"
read nombre

echo "Dirección:"
read direccion

echo "Puesto:"
read puesto

echo "Sueldo semanal (en enteros):"
read sueldo_semanal

echo "Días trabajados:"
read dias_trabajados

echo "Horas extras trabajadas:"
read horas_extras

# Convertir sueldo semanal a centavos para trabajar con enteros
sueldo_semanal_cent=$(($sueldo_semanal * 100))
sueldo_diario_cent=$(($sueldo_semanal_cent / 7))

# Cálculos básicos
total_sueldo_cent=$(($sueldo_diario_cent * $dias_trabajados))

# Calcular pago por horas extras en centavos
if [ $horas_extras -le 8 ]; then
    pago_horas_extras_cent=$(($horas_extras * $sueldo_diario_cent * 2 / 7))
else
    horas_extras_dobles=8
    horas_extras_triples=$(($horas_extras - 8))
    pago_horas_extras_dobles_cent=$(($horas_extras_dobles * $sueldo_diario_cent * 2 / 7))
    pago_horas_extras_triples_cent=$(($horas_extras_triples * $sueldo_diario_cent * 3 / 7))
    pago_horas_extras_cent=$(($pago_horas_extras_dobles_cent + $pago_horas_extras_triples_cent))
fi

# Total a pagar en centavos
total_a_pagar_cent=$(($total_sueldo_cent + $pago_horas_extras_cent))

# Deducciones ISPT en centavos
if [ $total_a_pagar_cent -le 250000 ]; then
    ispt_cent=$(($total_a_pagar_cent * 6 / 100))
else
    ispt_cent=$(($total_a_pagar_cent * 7 / 100))
fi

# Deducciones IMSS en centavos
if [ $total_a_pagar_cent -le 300000 ]; then
    imss_cent=$(($total_a_pagar_cent * 3 / 100))
else
    imss_cent=$(($total_a_pagar_cent * 4 / 100))
fi

# Cuota sindical en centavos
cuota_sindical_cent=$(($total_a_pagar_cent * 2 / 100))

# Total de deducciones en centavos
total_deducciones_cent=$(($ispt_cent + $imss_cent + $cuota_sindical_cent))

# Total neto a pagar en centavos
total_neto_cent=$(($total_a_pagar_cent - $total_deducciones_cent))

# Convertir centavos a unidades completas para mostrar
total_sueldo=$(echo "scale=2; $total_sueldo_cent / 100" | awk '{printf "%.2f", $1}')
pago_horas_extras=$(echo "scale=2; $pago_horas_extras_cent / 100" | awk '{printf "%.2f", $1}')
total_a_pagar=$(echo "scale=2; $total_a_pagar_cent / 100" | awk '{printf "%.2f", $1}')
ispt=$(echo "scale=2; $ispt_cent / 100" | awk '{printf "%.2f", $1}')
imss=$(echo "scale=2; $imss_cent / 100" | awk '{printf "%.2f", $1}')
cuota_sindical=$(echo "scale=2; $cuota_sindical_cent / 100" | awk '{printf "%.2f", $1}')
total_deducciones=$(echo "scale=2; $total_deducciones_cent / 100" | awk '{printf "%.2f", $1}')
total_neto=$(echo "scale=2; $total_neto_cent / 100" | awk '{printf "%.2f", $1}')

# Mostrar resultados
echo "=========================================="
echo "Nombre del trabajador: $nombre"
echo "Dirección: $direccion"
echo "Puesto: $puesto"
echo "Sueldo semanal: $sueldo_semanal"
echo "Días trabajados: $dias_trabajados"
echo "Horas extras trabajadas: $horas_extras"
echo "=========================================="
echo "Total sueldo (sin horas extras): $total_sueldo"
echo "Pago por horas extras: $pago_horas_extras"
echo "Total a pagar (con horas extras): $total_a_pagar"
echo "=========================================="
echo "Deducciones:"
echo "  ISPT: $ispt"
echo "  IMSS: $imss"
echo "  Cuota sindical: $cuota_sindical"
echo "Total de deducciones: $total_deducciones"
echo "=========================================="
echo "Total neto a pagar: $total_neto"

