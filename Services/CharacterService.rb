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
        characterList.each_with_index do |character, index|
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
end