MVC
    -Model
        -AtivoPatrimonial
            -id
            -nome
            -ambiente
        -Ambiente
            -id
            -nome
            -responsavel
        -Responsavel
            -id
            -nome

    -Repository
        -AtivoPatrimonialRepository
        -AmbienteRepository
        -ResponsavelRepository

    -Controller
        -AtivoPatrimonialController
        -AmbienteController
        -ResponsavelController


DEPENDENCIAS
jpa
thymeleaf
devtools
postgresdriver
springweb
lombok