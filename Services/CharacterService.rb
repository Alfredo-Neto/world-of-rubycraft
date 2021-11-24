require_relative '../Entity/Personagem'

class CharacterService
    #deixar de retornar um array de hashes e passar a retornar um array de objetos Personagem
    def getAll(filter = null)
        file = File.open("characters.json")
        characterList = file.read()
        begin
            characterList = JSON.parse(characterList)
        rescue JSON::ParserError
            characterList = []
        end
        file.close()
   
        personagensArray = []
        characterList.each do |character|
            personagem = Personagem.new
            personagem.nome = character["nome"]
            personagem.classe = character["classe"]
            personagem.atributos = character["atributos"]
            personagem.ataques = character["ataques"]
            personagem.tipo = character["tipo"]
            personagensArray.push(personagem)
        end
             
    #receber uma string para ser usada cmo um filtro, se ela for null, nao fazer nada, e só
    #fazer algo se ela for diferente de null
    #valores possiveis da string que vai chegar pelos paametros de getAll():
        #null
        #'player'
        #'enemy'
        personagensArray.each_with_index do |personagem, index|
            if personagem.tipo != filter
                personagensArray.delete_at(index)
            end
        end
        return personagensArray
    end

    def getOne(nome)
        characterList = getAll()
        characterList.each do |character|
            if character.nome == nome
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

    def buildDefaultCharacter(nome, classe, inimigo)
        atributos = defaultAtributos()
        ataques = defaultAtaques()
        personagem = Personagem.new
        personagem.nome = nome
        personagem.classe = classe
        personagem.atributos = atributos
        personagem.ataques = ataques
        personagem.tipo = inimigo ? 'enemy' : 'player'
        return personagem
    end
end