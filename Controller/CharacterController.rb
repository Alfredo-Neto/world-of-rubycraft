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
        
        character = @characterService.buildDefaultCharacter(nome, classe, false)
        @characterService.create(character)
    end

    def createEnemy()
        puts "Digite o nome do inimigo"
        nome = gets.chomp
        puts "Digite a classe do inimigo"
        classe = gets.chomp
        
        enemy = @characterService.buildDefaultCharacter(nome, classe, true)
        @characterService.create(enemy)
    end

end
