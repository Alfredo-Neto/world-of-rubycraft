require_relative 'Controller/CharacterController'

menu = 1
while menu
    puts "Digite um número para escolher uma opção:"
    puts "1 - Criar personagem"
    puts "2 - Sair"
    opcao = gets.chomp.to_i

    character = CharacterController.new
    case opcao
    when 1
        character.createCharacter()
    when 2
        return
    else
        puts "Opção inválida"
    end
end