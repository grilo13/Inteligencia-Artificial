# Estrutura para representar os estados 
- ((MargemEsquerda,CanibaisEsquerda),(LadoBarco,MissionariosBarco,CanibaisBarco),(Md,Cd))

## Depos temos os estados inicial e final
- estado_inicial()
- estado_final()

## Operações transições de estado/ações

 - ((Me,Ce),(Lb,Mb,Cb)),EncheBarco,((Me,Ce),(Lb,Mb,Cb),(Md,Cd)) -> lb=esq
 
 - EncheBarco (acima)
 - Descarrega
 - MovEsquerda
 - MovDireita