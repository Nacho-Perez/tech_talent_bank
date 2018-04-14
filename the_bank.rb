# TECH TALENT BANK

require_relative 'bank_classes'     #Igual que: ../bank-clases
#'require' para librerías del sistema, 'require_relative' para mis librerías

@cuentas = []
@clientes = []

@cliente_actual = nil
@cuenta_actual = nil

def menu
    puts "\n---------     BIENVENIDO A TECH TALENT BANK     ---------"
    puts "\nPor favor, selecciona una opción:"
    puts "1. Entrar como cliente"
    puts "2. Registrar nuevo cliente"
    puts "3. Salir"
    
    opcion = gets.chomp.to_i
    
    case opcion
        when 1 then login
        when 2 then registrar
        when 3 then puts "Cerrando aplicación ..."
    end
end 
def login
    puts "\nLOGIN DE CLIENTE"
    print "Introduzca su DNI: "
    dni = gets.chomp
    print "Introduzca su PIN: "
    pin = gets.chomp
    
    @cliente_actual = nil
    
    #¿Hay en @clientes algún cliente con ese DNI?
    @clientes.each do |cliente|
        if cliente.dni == dni
            #Comprobar el PIN
            if cliente.login(pin)
                @cliente_actual = cliente
            else
                puts "PIN incorrecto"
                menu                     #Volver al menú principal
            end
        end
    end
    
    if @cliente_actual != nil
        puts "-> Bienvenido/a #{@cliente_actual.nombre}"
        menu_gestion_cuentas
    else
        puts "-> Cliente no encontrado"
        menu                             #Volver al menú principal 
    end
    
end
def registrar
    puts "\nREGISTRO DE NUEVO CLIENTE"
    print "Introduzca su DNI: "
    dni = gets.chomp
    print "Introduzca su PIN: "
    pin = gets.chomp
    print "Introduzca su nombre: "
    nombre = gets.chomp
    
    nuevo_cliente = Cliente.new(dni, pin, nombre)
    @clientes.push(nuevo_cliente)
    
    puts "-> Cliente registrado correctamente"
    menu        #Volver al menú prinicipal
end
def menu_gestion_cuentas
    puts "\nGESTIÓN DE CUENTAS"
    puts "Por favor, seleccione una opción:"
    puts "1. Crear nueva cuenta"
    puts "2. Entrar a una cuenta"
    puts "3. Cerrar sesión"
    
    opcion = gets.chomp.to_i
    case opcion
        when 1 then crear_cuenta
        when 2 then menu_seleccionar_cuenta
        when 3 
            puts "-> Cerrando sesión ..."
            menu
        else 
            puts "-> Opción incorrecta"
            menu_gestion_cuentas
    end
end
def crear_cuenta
    puts "\nCREAR CUENTA"
    print "Introduzca saldo inicial: "
    saldo = gets.chomp.to_f
    print "Introduzca el tipo de cuenta: "
    tipo = gets.chomp
    
    nueva_cuenta = Cuenta.new(@cliente_actual, @cuentas.length+1, saldo, tipo)
    @cuentas.push(nueva_cuenta)
    
    puts "-> Cuenta creada satisfactoriamente"
    menu_gestion_cuentas            #Volver al menú de gestión de cuentas
end
def menu_seleccionar_cuenta
    puts "\nSELECCIONAR CUENTA"
    print "Introduzca el tipo de su cuenta: "
    tipo = gets.chomp
    
    @cuenta_actual = nil
    
    @cuentas.each do |cuenta|
        if (cuenta.cliente == @cliente_actual) && (cuenta.tipo == tipo)
            @cuenta_actual = cuenta  
        end
    end
    
    if @cuenta_actual != nil
        menu_acciones_cuenta     
    else
        puts "-> El cliente con nombre #{@cliente_actual.nombre} no tiene ninguna cuenta de tipo #{tipo} asociada."
        menu_gestion_cuentas    
    end
end
def menu_acciones_cuenta
    puts "\nACCIONES SOBRE LA CUENTA"
    puts "1. Ver saldo"
    puts "2. Hacer ingreso"
    puts "3. Retirar dinero"
    puts "4. Volver al menú de cuentas"
    puts "5. Cerrar sesión"
    
    opcion = gets.chomp.to_i
    
    case opcion
        when 1 
            puts "-> Su saldo actual es de #{@cuenta_actual.saldo} €"
            menu_acciones_cuenta
        when 2 
            @cuenta_actual.ingresar
            menu_acciones_cuenta
        when 3 
            @cuenta_actual.retirar
            menu_acciones_cuenta
        when 4 then menu_gestion_cuentas
        when 5 then menu
        else
            "-> Opción incorrecta, inténtelo de nuevo"
            menu_acciones_cuenta
    end
end

#Llamamos al método menu para que comience el programa
menu