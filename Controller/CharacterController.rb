require_relative '../Services/CharacterService'

class CharacterController
    def initialize
        @characterService = CharacterService.new
    end

    def createCharacter()
        puts "Digite o nome do personagem"
        nome = gets.chomp
        puts "Digite a classe do personagem"
        classe = gets.chomp
        
        character = @characterService.buildDefaultCharacter(nome, classe)
        @characterService.create(character)
    end
end
