require_relative '../Services/CharacterService'

class CharacterController

    # def initialize(storageType)
    #     setStorageType(storageType)
    # end

    def initialize
        @characterService = CharacterService.new
    end

    # def setStorageType storageType
    #     case storageType
    #     when 'json'
    #         @storageType = storageType
    #     when 'relationalDatabase'
    #         @storageType = storageType
    #     else
    #         raise "opçao ainda nao suportada"
    #     end
    # end

    def createCharacter()
        puts "Digite o nome do personagem"
        nome = gets.chomp
        puts "Digite a classe do personagem"
        classe = gets.chomp
        
        character = @characterService.buildDefaultCharacter(nome, classe)
        # save(character)
        @characterService.create(character)
    end
 

    # def save character
    #     case @storageType
    #     when 'json'
    #         saveJson(character)
    #     when 'relationalDatabase'
    #         saveRelationalDatabase(character)
    #     else
    #         raise "opçao ainda nao suportada"
    #     end
    # end

    # def saveRelationalDatabase character
    #     raise "opçao ainda nao suportada"
    # end
    
end
