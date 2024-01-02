user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")


user1_cats = [
    {
        name: "Dan",
        age: 13,
        enjoys: "eating wet food",
        image: 'https://as2.ftcdn.net/v2/jpg/03/03/62/45/1000_F_303624505_u0bFT1Rnoj8CMUSs8wMCwoKlnWlh5Jiq.jpg'
    },
    {
        name: "Nova",
        age: 2,
        enjoys: "sleeping all day",
        image: 'https://as2.ftcdn.net/v2/jpg/00/77/51/81/1000_F_77518136_F88I0v3R2mZsKEgxxXMc4iqXlOjK8OLE.jpg'
    }
]
user2_cats = [
    {
        name: "Stevie",
        age: 3,
        enjoys: "hiding under the couch",
        image: 'https://th-thumbnailer.cdn-si-edu.com/bgmkh2ypz03IkiRR50I-UMaqUQc=/1000x750/filters:no_upscale():focal(1061x707:1062x708)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/55/95/55958815-3a8a-4032-ac7a-ff8c8ec8898a/gettyimages-1067956982.jpg'
    }
]

user1_cats.each do |cat|
    user1.cats.create cat
    puts "creating cat #{cat}"
end

user2_cats.each do |cat|
    user2.cats.create cat
    puts "creating cat #{cat}"
end
