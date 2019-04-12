require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    #Cria o Usuário
    let!(:user) {create(:user)}
    let(:user_id) {user.id}
    let(:headers) {{"Accept" => "application/vnd.projetofase8.v2", "Authorization" =>user.auth_token
        }}
    
    #Define Host
    before {host! "localhost:3000/api"} 
    
    describe "GET user/:id" do #Get = Consultar
        
        before do #define variavel headers ANTES DE COMEÇAR
           get "/users/#{user_id}", params: {}, headers: headers
        end
        
        #Quando o Usuário existir, retorna um Usuário como JSON e retorna o Código 200(deu certo)
        context "when the user exists" do
            it "returns the user" do
                expect(json_body["id"]).to eq(user_id)
            end
            #Retorna o codigo 200
            it "return status code 200" do
                expect(response).to have_http_status(200)
            end
        end
        #Quando o usuário não existir, retorna erro 404(requisição não encontrada)
        context "when the user does not exists" do
            #Esse método let é um teste que não temos, para provar
            let(:user_id){ 10000 }
            
            it "return status code 404" do
                expect(response).to have_http_status(404)
            end
        end
    end
    describe "POST user/" do #Post = Criar
        before do #define variavel headers ANTES DE COMEÇAR 
            post "/users/", params: { user: user_params }, headers: headers 
            #Headers tá passando os parametros de usuário
        end
        #Quando as requisições são validas, retorna o Código 201
        context "when the request params are valid" do
            let(:user_params){ attributes_for(:user) }
            #retorna o código 201
            it "returns status code 201" do
                expect(response).to have_http_status(201)
            end
            
            it "returns json data for the created user" do
                # Retorna o Usuário criado em Json
                expect(json_body["email"]).to eq(user_params[:email])
            end
        end
        # Quando os parametros da requisição for invalida, retorna o código 422(Requisição está certa mas voce passou a requisição errado)
        context "when the request params are invalid" do
            #Esse método let é um teste que não temos, para provar
            let(:user_params){attributes_for(:user, email: "email_invalido@") }
            it "return status code 422" do
                expect(response).to have_http_status(422)
            end
            # Retorna uma chave com um Json com o erro da requisição
            it "returns json data for the errors" do
                expect(json_body).to have_key('errors')
            end
        end
    end
    describe "PUT user/:id" do #Put = Atualizar
        before do #define variavel headers ANTES DE COMEÇAR
            put "/users/#{user_id}", params: { user: user_params }, headers: headers 
            #Headers tá passando os parametros de usuário
        end
        #Quando as requisições são validas, retorna o Código 201
        context "when the request params are valid" do
            let(:user_params){{ email: 'novo@email.com'}}
            #retorna o código 200
            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end
            
            it "returns json data for the created user" do
                # Retorna o Usuário criado em Json
                expect(json_body["email"]).to eq(user_params[:email])
            end
        end
        # Quando os parametros da requisição for invalida, retorna o código 422(Requisição está certa mas voce passou a requisição errado)
        context "when the request params are invalid" do
            #Esse método let é um teste que não temos, para provar
            let(:user_params){{email: "email_invalido@" }}
            it "return status code 422" do
                expect(response).to have_http_status(422)
            end
            # Retorna uma chave com um Json com o erro da requisição
            it "returns json data for the errors" do
                expect(json_body).to have_key('errors')
            end
        end
    end
    describe "DELETE user/:id" do #Delete...
        before do #define variavel headers ANTES DE COMEÇAR
           delete "/users/#{user_id}", params: {}, headers: headers 
        end
        it "returns status code 204" do
            expect(response).to have_http_status(204)
        end
            
        it "removes the user from database" do
            expect(User.find_by(id: user.id) ).to be_nil
        end
    end
end