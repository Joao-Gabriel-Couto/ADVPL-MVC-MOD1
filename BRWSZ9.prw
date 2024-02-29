#include "Protheus.ch"
#include "FWMVCDEF.ch"


User Function BRWSZ9()

Local aArea := GetNextAlias()

//Instanciamento da Classe FwmBrowse
Local oBrowseSZ9 

oBrowseSZ9 := FwmBrowse():New()

//Paramento tela do Browse
oBrowseSZ9:SetAlias("SZ8")

//Titulo da Tela
oBrowseSZ9:SetDescription("Tela MVC")

//Adição legenda de cores para filtrar
oBrowseSZ9:AddLegend("Z8_STATUS=='1' " ,"GREEN" ,"ATIVO")
oBrowseSZ9:AddLegend("Z8_STATUS== '2' " , "RED " , "INATIVO")


oBrowseSZ9:Activate()
Return

Static Function MenuDef()

Local aRotina := {}
ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.BRWSZ9' OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.BRWSZ9' OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.BRWSZ9' OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.BRWSZ9' OPERATION 5 ACCESS 0
ADD OPTION aRotina TITLE 'Imprimir'   ACTION 'VIEWDEF.BRWSZ9' OPERATION 8 ACCESS 0
ADD OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.BRWSZ9' OPERATION 9 ACCESS 0
ADD OPTION aRotina TITLE 'Legenda'     ACTION 'u_SZ8LEG'      OPERATION 6 ACCESS 0

Return (aRotina)

Static Function ModelDef()
Local oModel // Modelo de dados que será construído


// Cria a estrutura a ser usada no Modelo de Dados
Local oStr1 := FWFormStruct( 1, 'SZ8' )

oModel := MPFormModel():New('ModelName')

// Adiciona ao modelo um componente de formulário
oModel:AddFields('MODEL_SZ8',, oStr1)

oModel:SetPrimaryKey({'SZ8_FILIAL','SZ8_ID'})
// Adiciona a descrição do Componente do Modelo de Dados

oModel:GetModel( 'MODEL_SZ8' ):SetDescription( 'Produto x Entrega' )

// Retorna o Modelo de dados
Return oModel

Static Function ViewDef()

// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
Local oView

//Retorna um objeto de model de um determinado fonte
Local oModel := FwLoadModel('BRWSZ9')

// Cria a estrutura a ser usada na View
Local oStr1 := FWFormStruct( 2, 'SZ8' )

// Contruindo a visão de dados
oView := FWFormView():New()

// Define qual o Modelo de dados será utilizado na View
oView:SetModel( oModel )

// Adiciona no nosso View um controle do tipo formulário 
oView:AddField( 'VIEW_SZ8', oStr1, 'MODEL_SZ8' )

// Criar um "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox( 'BOX_SUPERIOR' , 100 )

// Relaciona o identificador (ID) da View com o "box" para exibição
oView:SetOwnerView( 'VIEW_SZ8', 'BOX_SUPERIOR' )

oView:EnableTitleView( "VIEW_SZ8", "Cadastro de Produto")


oView:SetCloseonOk({||.T.})

Return oView

User Function SZ8LEG()

Local aLegenda := {}

aAdd(aLegenda,{"BR_VERDE",     "Ativo"})
aAdd(aLegenda,{"BR_VERMELHO", "Inativo"})

BrwLegenda("Registros","Ativos/Inativos",aLegenda)

Return aLegenda
