local Translations = {
    -- general Notify
    error = {
        no_pet_under_control = 'Precisa de um animal de estimação sob seu controle para fazer isso!',
        badword_inside_pet_name = 'Que nome feio!',
        more_than_one_word_as_name = 'O nome do seu animal de estimação não pode conter mais de uma palavra!',
        failed_to_start_procces = 'Falhou ao iniciar o processo!',
        failed_to_find_pet = 'Não foi possível encontrar o animal de estimação!',
        could_not_do_that = 'Não foi possível fazer isso!',
        string_type = 'O nome do seu animal de estimação deve ser uma string!',
        not_enough_first_aid = 'Você não tem kits de primeiros socorros suficientes!',
        reached_max_allowed_pet = 'Você atingiu o número máximo de animais de estimação permitidos!',
        failed_to_validate_name = 'Nome inválido: %s',
        failed_to_rename = 'Falha ao renomear o animal de estimação!',
        failed_to_rename_same_name = 'O nome do seu animal de estimação já é esse!',
        your_pet_is_dead = 'Seu animal de estimação está morto!',
        your_pet_died_by = 'Seu animal de estimação morreu por %s',
        not_owner_of_pet = 'Você não é o dono deste animal de estimação!',

        failed_to_remove_item_from_inventory = 'Falha ao remover o item do inventário!',
        failed_to_transfer_ownership_same_owner = 'Você já é o dono deste animal de estimação!',
        failed_to_transfer_ownership_could_not_find_new_owner_id = 'Não foi possível encontrar o ID do novo proprietário!',
        failed_to_transfer_ownership_missing_current_owner = 'Faltando o proprietário atual!',

        not_enough_water_bottles = 'Faltam garrafas de água!',
        not_enough_water_in_your_bottle = 'Não há água suficiente na sua garrafa!',

        pet_died = '%s Morreu :(',
    },
    success = {
        pet_initialization_was_successful = 'Buscando animal de estimação com sucesso!',
        pet_rename_was_successful = 'Seu animal de estimação foi renomeado para: %s',
        healing_was_successful = "Saúde do pet: %s maxHealth: %s",
        successful_revive = '%s foi revivido com sucesso!',
        successful_ownership_transfer = 'Você transferiu com sucesso a propriedade do seu animal de estimação para %s (ID: %s)',
        successful_drinking = 'Seu pet bebeu água e recuperou %s de sede',
        successful_grooming = 'Seu pet foi cuidado com sucesso',
    },
    info = {
        use_3th_eye = 'Use o Alt para interagir com seu animal de estimação',
        full_life_pet = 'Seu animal de estimação já está com a vida cheia',
        still_on_cooldown = "Ainda em cooldown por %s segundos",
        level_up = '%s Subiu de nível %d'
    },
    menu = {
        general_menu_items = {
            btn_leave = 'Sair',
            btn_back = 'Voltar',
            success = 'sucesso',
            confirm = 'Confirmar'
        },

        main_menu = {
            header = 'Nome: %s',
            sub_header = 'pet sob seu controle',
            btn_actions = 'Actions',
            btn_switchcontrol = 'Switch Control',
            switchcontrol_header = 'Switch Pet Under Your Control',
            switchcontrol_sub_header = 'click on pet which you want to control',
        },

        action_menu = {
            header = 'Name: %s',
            sub_header = 'pet sob seu controle',
            follow = 'Seguir',
            hunt = 'Caçar',
            hunt_and_grab = 'Caçar e pegar',
            go_there = 'Vai alí',
            wait = 'Espera aqui',
            get_in_car = 'Entre no carro',
            beg = 'Faça algum truque',
            paw = 'Pata',
            play_dead = 'Morto',
            tricks = 'Truques',
            error = {
                pet_unable_to_hunt = "Seu pet não caça!",
                not_meet_min_requirement_to_hunt = 'Seu pet precisa de um nível mínimo. (min level: %s)',
                already_hunting_something = 'Já está caçando algo!',
                pet_unable_to_do_that = 'Seu pet não pode fazer isso!',

                -- get into car
                need_to_be_inside_car = 'Você precisa estar dentro de um carro!',
                to_far = 'Muito longe do carro!',
                no_empty_seat = 'Não há assento vazio no carro!',
            },
            success = {


            },
            info = {

            }
        },

        tricks = {
            header = 'Nome: %s',
            sub_header = 'pet sob seu controle',

        },

        switchControl_menu = {
            header = 'Nome: %s',
            sub_header = 'pet sob seu controle',

        },

        customization_menu = {
            header = 'Menu de personalização',
            sub_header = '',

            btn_rename = 'Renomear',
            btn_txt_btn_rename = 'nome atual: ',

            btn_select_variation = 'Selecionar variação',
            btn_txt_select_variation = 'variação atual: ',


            rename = {
                inputs = {
                    header = 'Escolha um novo nome',
                }
            }
        },

        rename_menu = {
            header = 'Nome atual',
            btn_rename = 'Rename',
        },

        variation_menu = {
            header = 'Cor atual',
            btn_select_variation = 'Selecionar variação',
            btn_txt_select_variation = 'escolha a variação para o seu pet',

            selection_menu = {
                header = 'Lista de variações',
                btn_variation_items = 'Variação: ',
                btn_desc = 'Selecione a variação para o seu pet',
            }

        },
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
