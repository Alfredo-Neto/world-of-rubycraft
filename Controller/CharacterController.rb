require 'json'

class CharacterController
    def createCharacter()
        puts "Digite o nome do personagem"
        nome = gets.chomp
        puts "Digite a classe do personagem"
        classe = gets.chomp
        character = buildCharacter(nome, classe)
        save(character)
    end
    
    def buildCharacter(nome, classe)
        character = {"nome" => nome, "classe" => classe}
        return character
    end
    #
    def save character
        file = File.open("characters.json")
        content = file.read
        content = JSON.parse(content)

        puts content.inspect
        content.push(character)
        puts content.inspect

        file.close

        content = content.to_json
        File.open("characters.json", "w") { |f| f.write content }
    end
    
end
