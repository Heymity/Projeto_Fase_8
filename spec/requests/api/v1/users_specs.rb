require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    #Cria o Usuario
    let!(:user) {create(:user)}
    let(:user_id) {user.id}
    
    #Deine Host
    before {host! "localhost:3000/api"}
    
    
    describe "GET user/:id" do
        before do
            headers = {"Accept" => "application/vnd.projetofase8.v1"}
            get "/user/#{user_id}", params: {}, headers: headers
        end
        
        context "when the user exists" do 
            it "returns the user" do
                user_response = JSON.parse(response.body)
                expect(user_reponse["id"]).to eq(user_id)
            end
            
            it "return status code 200" do
                expect(response).to have_http_status(200)
            end
        end
        
        context "when the user does not exists" do
            let(:user_id){ 10000 }
            
            it "return status code 404" do
                expect(response).to have_http_status(404)
            end
        end
    end
    describe "POST user/" do
        before do
            headers = {"Accept" => "application/vnd.projetofase8.v1"}
            post "/users/", params: {user: user_params[:email] }
            
        end
        
        context "when the request params are valid" do 
            let (:user_params) {attributes_for(:user)}
            
            
            it "returns status code 201" do
                user_response = JSON.parse(response.body)
                expect(user_reponse["id"]).to eq(user_id)
                expect(response).to have_http_status(201)
            end
            
            it "returns json data for the created user" do
                user_response = JSON.parse(response.body)
                expect(user_reponse["email"]).to eq(user_params[:email])
            end
        end
        
        context "when the request params are invalid" do
            let(:user_params){attributes_for(:user, email: "email_invalidos@")}
            
            it "returns status code 422" do
                expect(response).to have_http_status(422)
            end
            it "return json data for the erros" do
                user_response = JSON.parse(response.body)
                expect(user_response).to have_key('erros')
            end
        end
    end
     
end 