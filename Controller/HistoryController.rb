
# eu escolho a opção de historia
# sistema mostra personagens e pede para eu escolher um
# eu escolho um personagem

# repete ate que todos os inimigos tenham sido derrotados ou o jogador morra
#     o sistema me joga contra o n-esimo personagem
#     mostra os atributos do personagem que escolhi
#     mostra os inimigos com quem vou lutar
#     repete até que a vida de algum chegue a zero - dizendo quem venceu o jogo
#         o sistema lista os ataques disponíveis (é a sua vez)
#         eu escolho um ataque
#         sistema diz qeu o personagem atacou com tal ataque
#         o sistema mostra quanto dano o ataque fez no inimigo (tambem dinimui a vida do inimigo)
#         sistema diz que agora eh a vez do inimigo
#         vai sempre usar o mesmo ataque
#         sistema vai dizer quanto dano o ataque causou, e diminui a vida do jogador
#     -----------
#     reseta a vida
# ----------

# se morreu - fala que morreu
# se terminou a história, estoura um champanhe
require_relative '../Services/CharacterService'

class HistoryController
    def initialize
        @characterService = CharacterService.new
    end

    def historyMode()
       characters = @characterService.getAll()
       charactersMenu(characters)
    end

    def charactersMenu(characters)
        while 1
            puts "Pressione um número para escolher um personagem:"
            @characterService.listCharacters(characters)
            opcao = gets.chomp
            if (opcao.to_i > 0 && opcao.to_i <= characters.length)
                nome = characters[opcao.to_i - 1]["nome"]
                character = @characterService.getOne(nome)
                @characterService.listAttributes(character)
                break
            else
                puts "Opção inválida!"
            end
        end
    end
end
