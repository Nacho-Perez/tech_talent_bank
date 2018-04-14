class Cliente
    attr_reader :dni
    attr_writer :pin
    attr_accessor :nombre
    
    def initialize(dni, pin, nombre)
        @dni = dni
        @pin = pin
        @nombre = nombre
    end
    
    def login(pin)
        @pin == pin    
    end    
end

class Cuenta
    attr_reader :saldo, :numero
    attr_accessor :cliente, :tipo
    
    def initialize(cliente, numero, saldo, tipo)
        @cliente = cliente
        @numero = numero
        @saldo = saldo
        @tipo = tipo
    end    
    
    def ingresar
        print "-> Introduzca la cantidad a ingresar: "
        cantidad = gets.chomp.to_f
        @saldo += cantidad
        puts "-> Ingreso realizado correctamente, su saldo ahora es #{@saldo} €"
    end
    def retirar
        print "-> Introduzca la cantidad a retirar: "
        cantidad = gets.chomp.to_f
        if cantidad > @saldo
            puts "-> No hay fondos suficientes"
        else 
            @saldo -= cantidad
            puts "-> Retirada realizada correctamente, su saldo ahora es #{@saldo} €"
        end
    end
end