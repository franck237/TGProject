# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

#Supprime les pércédentes lignes de la BDD mais l'incrémentation des index continue !
City.destroy_all
User.destroy_all
Gossip.destroy_all
Tag.destroy_all
JoinGotag.destroy_all
PrivateMessage.destroy_all

#Création de 10 villes aléatoires
	random_city_list = []
10.times do
	random_city = City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
	random_city_list << random_city
end

#Création de 10 utilisateurs aléatoires portant chacun une des villes précedemment crées en argument foreign key
	random_user_list = []
10.times do
	random_user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence(word_count: 9, supplemental: false, random_words_to_add: 10), email: Faker::Internet.email, age: Faker::Number.within(range: 18..70), city: random_city_list.sample)
	random_user_list << random_user
end

#Création de 20 utilisateurs aléatoires portant chacun un user aléatoire précedemment crée en argument foreign key
	random_gossip_list = []
20.times do
	random_gossip = Gossip.create(title: Faker::Book.title, content: Faker::Lorem.sentence(word_count: 9, supplemental: false, random_words_to_add: 10), user: random_user_list.sample)
	random_gossip_list << random_gossip
end

#Création de 10 tags aléatoires
	random_tag_list = []
10.times do
	random_tag = Tag.create(title: Faker::Lorem.words(number: 1))
	random_tag_list << random_tag
end

#Création de 20 lignes dans la table jointe de Gossip et Tags pour lier les 20 Gossip à un tag aléatoire parmi les 10 tags crées précedement avec en foreign key gossip et tag pour une relation N Gossips  - N Tags
	i=0
20.times do
	random_join_gotag = JoinGotag.create(gossip: random_gossip_list[i], tag: random_tag_list.sample)
	i = i + 1
end

#Création de 40 lignes supplémentaires dans la table jointe de Gossip et Tags pour ajouter quelques tags à certain Gossip de facon aléatoires
40.times do
	i = rand(1..20)
	random_join_gotag = JoinGotag.create(gossip: random_gossip_list[i], tag: random_tag_list.sample)
end

#Création de 30 messages privés aléatoires
30.times do
	random_private_message = PrivateMessage.create(content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2), sender: random_user_list.sample, recipient: random_user_list.sample)
end