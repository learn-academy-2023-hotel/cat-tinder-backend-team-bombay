require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do 
    it 'returns all cat objects' do
      Cat.create(
        name: 'Nova',
        age: 2,
        enjoys: 'sleeping on the couch',
        image: 'https://as2.ftcdn.net/v2/jpg/00/77/51/81/1000_F_77518136_F88I0v3R2mZsKEgxxXMc4iqXlOjK8OLE.jpg'
      )

      get '/cats'
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end

    # Creates a cat
    describe "POST /create" do
      it "creates a cat" do
        cat_params = {
          cat:{
            name: "Stevie",
            age: 3,
            enjoys: "hiding on the couch",
            image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
          }
        }

        post '/cats', params: cat_params

        expect(response).to have_http_status(200)

        cat = Cat.first
        expect(cat.name).to eq 'Stevie'
      end
    end

    # Updates a cat
    describe "PATCH / update" do
      it "updates a cat" do

        # create a cat and use cat_params to pass to the database
        cat_params = {
          cat:{
            name: "Stevie",
            age: 3,
            enjoys: "hiding on the couch",
            image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
          }
        }
        post '/cats', params: cat_params
        cat = Cat.last
        
        #update the cat
          cat_params_update ={
            cat:{
              name: "Stevie",
              age: 5,
              enjoys: "eating a lot",
              image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
            }
          }
        
        patch "/cats/#{cat.id}", params: cat_params_update

        # updated_cat = Cat.find(cat.id)
        # checks for successful response
        expect(response).to have_http_status 200
        # expect(updated_cat.enjoys). to eq "eating a lot"

        # cat = JSON.parse(response.body) => dont need this
        cat = Cat.first
        expect(cat.enjoys).to eq 'eating a lot'
      end
    end


    # Deletes cat
    describe "DELETE / destroy" do
      it "deletes a cat" do
        cat_params = {
          cat: {
            name: "Stevie",
            age: 5,
            enjoys: "eating a lot",
            image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
          }
        }
        post '/cats', params: cat_params 
        cat = Cat.first

        delete "/cats/#{cat.id}" #call your cat and deletes it
        expect(response).to have_http_status 200
      end
    end

    describe "cannot create a cat without valid attributes" do 
     it "doesn't create a cat without a name" do
      cat_params = {
        cat: {
          age: 2,
          enjoys: "hiding under the couch",
          image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status 422
      cat = JSON.parse(response.body)
      expect(cat['name']).to include "can't be blank"
    end 

    it "doesn't create a cat without an age" do
      cat_params = {
        cat: {
          name: 'Stevie',
          enjoys: "hiding under the couch",
          image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status 422
      cat = JSON.parse(response.body)
      expect(cat['age']).to include "can't be blank"
  end

    it "doesn't create a cat without an enjoys description" do
      cat_params = {
        cat: {
          name: 'Stevie',
          age: 2,
          image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status 422
      cat = JSON.parse(response.body)
      expect(cat['enjoys']).to include "can't be blank"
  end 

    it "doesn't create a cat without an image" do
      cat_params = {
        cat: {
          name: 'Stevie',
          age: 2,
          enjoys: 'hiding under the couch'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status 422
      cat = JSON.parse(response.body)
      expect(cat['image']).to include "can't be blank"
    end 
  end

  describe "cannot update a cat without valid attributes" do 
    it "doesn't update a cat without a name" do
     cat_params = {
       cat: {
         name: 'Stevie',
         age: 2,
         enjoys: "hiding under the couch",
         image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
       }
     }
     post '/cats', params: cat_params
     cat = Cat.first

     cat_params_update ={
      cat:{
        name: '',
        age: 5,
        enjoys: "eating a lot",
        image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
      }
    }
    patch "/cats/#{cat.id}", params: cat_params_update
    expect(response).to have_http_status 422
    # cat = Cat.first
    cat = JSON.parse(response.body)
    expect(cat['name']).to include "can't be blank"
  end 

    it "doesn't update a cat without an age" do
      cat_params = {
        cat: {
          name: 'Stevie',
          age: 2,
          enjoys: "hiding under the couch",
          image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
 
      cat_params_update ={
       cat:{
         name: 'Stevie',
         age: '',
         enjoys: "eating a lot",
         image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
       }
     }
      patch "/cats/#{cat.id}", params: cat_params_update
      expect(response).to have_http_status 422
      cat = JSON.parse(response.body)
      expect(cat['age']).to include "can't be blank"
    end 
 
     it "doesn't update a cat without an enjoys description" do
      cat_params = {
        cat: {
          name: 'Stevie',
          age: 2,
          enjoys: "hiding under the couch",
          image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
 
      cat_params_update ={
       cat:{
         name: 'Stevie',
         age: 5,
         enjoys: "",
         image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
       }
     }
     patch "/cats/#{cat.id}", params: cat_params_update
     expect(response).to have_http_status 422
     cat = JSON.parse(response.body)
     expect(cat['enjoys']).to include "can't be blank"
     end  

     it "doesn't update a cat without an image" do
      cat_params = {
        cat: {
          name: 'Stevie',
          age: 2,
          enjoys: "hiding under the couch",
          image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
 
      cat_params_update ={
       cat:{
         name: 'Stevie',
         age: 5,
         enjoys: "eating a lot",
         image: ''
       }
     }
     patch "/cats/#{cat.id}", params: cat_params_update
     expect(response).to have_http_status 422
     cat = JSON.parse(response.body)
     expect(cat['image']).to include "can't be blank"
     end 
  end
end






