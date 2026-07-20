#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

CUSTOMER() {
  ID_SERVICE=$1
  NAME_SERVICE=$2

  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # Si el cliente no existe
  if [[ -z $CUSTOMER_ID ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    # Insertar nuevo cliente
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")

    # Obtener el customer_id recién creado
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  else
    # Si el cliente ya existe, traemos su nombre de la BD
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID")
  fi

  # Pedir la hora de la cita
  echo -e "\nWhat time would you like your $NAME_SERVICE, $CUSTOMER_NAME?"
  read SERVICE_TIME

  # Insertar la cita
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $ID_SERVICE, '$SERVICE_TIME')")

  # Mensaje de confirmación exigido por FreeCodeCamp
  echo -e "\nI have put you down for a $NAME_SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
}

MAIN_MENU(){
  if [[ $1 ]]
    then
      echo -e "\n$1"
    fi

  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")

  echo "$SERVICES" | while IFS="|" read SERVICE_ID NAME
  do
    echo "$SERVICE_ID) $NAME" 
  done

  read SERVICE_ID_SELECTED

  NAME_SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")

  if [[ -z $NAME_SERVICE_SELECTED ]] 
    then
      MAIN_MENU "I could not find that service. What would you like today?"
    else
      CUSTOMER "$SERVICE_ID_SELECTED" "$NAME_SERVICE_SELECTED"
    fi


}

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"
MAIN_MENU