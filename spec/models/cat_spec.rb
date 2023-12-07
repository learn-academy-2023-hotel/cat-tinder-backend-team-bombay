require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should validate name" do
    cat = Cat.create(age: 3, enjoys: 'hiding under the couch', image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg')
    expect(cat.errors[:name]).to_not be_empty
  end
  it "should validate age" do
    cat = Cat.create(name: 'Stevie', enjoys: 'hiding under the couch', image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg')
    expect(cat.errors[:age]).to_not be_empty
  end
  it "should validate enjoys" do
    cat = Cat.create(name: 'Stevie', age: 3, image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg')
    expect(cat.errors[:enjoys]).to_not be_empty
  end
  it "should validate image" do
    cat = Cat.create(name: 'Stevie', age: 3, enjoys: 'hiding under the couch')
    expect(cat.errors[:image]).to_not be_empty
  end
  it "validates enjoys is at least 10 characters" do
    cat = Cat.create(name: 'Stevie', age: 3, enjoys: 'hiding', image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg')
    expect(cat.enjoys).to_not be_empty
  end 
end
