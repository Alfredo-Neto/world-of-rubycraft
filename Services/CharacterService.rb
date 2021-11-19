class CharacterService
    def getAll ()
        file = File.open("characters.json")
        characterList = file.read()
        begin
            characterList = JSON.parse(characterList)
        rescue JSON::ParserError
            characterList = []
        end
        file.close()
        return characterList
    end

    def getOne(nome)
        characterList = getAll()
        characterList.each do |character|
            if character["nome"] == nome
                return character
            end 
        end
    end

    def create (character)
        characterList = getAll()
        characterList.push(character)
        saveJson(characterList)
    end

    def saveJson (characterList)
        characterList = characterList.to_json()
        File.open("characters.json", "w") {
            |f| f.write characterList
        }
    end

    def defaultAtaques ()
        return [
            {
                "nome" => "soco de massa infinita",
                "dano" => 10
            },
            {
                "nome" => "soco de massa finita",
                "dano" => 2
            },
        ]
    end

    def defaultAtributos ()
        return {
            "vidaMaxima" => 100,
            "vida" => 100
        }
    end

    def buildDefaultCharacter(nome, classe)
        atributos = defaultAtributos
        ataques = defaultAtaques
        character = {
            "nome" => nome,
            "classe" => classe,
            "atributos" => atributos,
            "ataques" => ataques
        }
        return character
    end

    def listCharacters(characters)
        characters.each_with_index do |character, index|
            puts "#{index += 1} - #{character["nome"]}"
        end
    end

    def  listAttributes(character)
        puts
        puts "Dados do personagem:"
        puts "Nome: #{character["nome"]}"
        puts "Classe: #{character["classe"]}"
        puts "Atributos:"
        puts "  Vida máxima: #{character["atributos"]["vidaMaxima"]}"
        puts "  Vida: #{character["atributos"]["vida"]}"
        puts "Ataques:"
        
        ataques = character["ataques"]
        ataques.each do |ataque|
            puts "  Nome: #{ataque["nome"]}, Dano: #{ataque["dano"]}"
        end
        puts
    end
end