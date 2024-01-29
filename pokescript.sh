#!/bin/bash

# Pedir al usuario que introduzca el nombre del Pokemon
read -p "Introduce el nombre del Pokemon: " pokemon_name

# Verificar que se haya proporcionado un nombre de Pokemon
if [ -z "$pokemon_name" ]; then
    echo "Por favor, proporciona un nombre de Pokemon."
    exit 1
fi

# Consultar la PokeApi con curl y parsear el resultado con jq
api_url="https://pokeapi.co/api/v2/pokemon/$pokemon_name"
result=$(curl -s "$api_url" | jq '.')

# Verificar si se obtuvo un error en la respuesta
error=$(echo "$result" | jq -r '.detail')
if [ "$error" != "null" ]; then
    echo "Error: $error"
    exit 1
fi

# Extraer los datos relevantes utilizando jq
id=$(echo "$result" | jq -r '.id')
name=$(echo "$result" | jq -r '.name')
weight=$(echo "$result" | jq -r '.weight')
height=$(echo "$result" | jq -r '.height')
order=$(echo "$result" | jq -r '.order')

# Imprimir los resultados formateados
echo "$name (No. $id)"
echo "Id = $id"
echo "Weight = $weight"
echo "Height = $height"
echo "Order = $order"
