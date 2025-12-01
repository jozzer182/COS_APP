int aEntero(String dato){
  if(dato.isEmpty) return 0;
  return num.parse(dato).toInt();
}

int aEnteroNoCero(String dato){
  if(dato.isEmpty) return 1;
  return int.parse(dato);
}

num aNumero(String dato){
  if(dato.isEmpty) return 0;
  return num.parse(dato);
}