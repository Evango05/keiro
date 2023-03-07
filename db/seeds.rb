puts "Destroying users, categories, hotspots, itineraries and joint tables"

Hotcat.destroy_all
Hotiti.destroy_all
User.destroy_all
Category.destroy_all
Hotspot.destroy_all
Itinerary.destroy_all

puts "Creating User Charlie (test@gmail.com - 123456)..."

User.create!({
  nickname: "Charlie",
  email: "test@gmail.com",
  password: "123456"
})

puts "Creating Hotspots..."

major = Hotspot.create!({
  name: "La Major - Cathédrale Sainte-Marie-Majeure",
  description: "Elle fut construite en style néo-byzantin entre 1852 et 1893 sur les plans de l'architecte Léon Vaudoyer. Située dans le quartier de la Joliette dans le 2e arrondissement, elle se dresse sur l'esplanade Jean-Paul II, entre le Vieux-Port et le port de la Joliette, sur l'emplacement de l'ancienne cathédrale du xiie siècle, d'où vient le nom occitan de « Major ».",
  address: "Place De la Major, Marseille 2ème"
})
major.photo.attach(io: File.open('./db/seed_pics/major.jpeg'), filename: 'major.jpeg', content_type: 'image/jpeg')
major.save!

ndlg = Hotspot.create!({
  name: "Basilique Notre-Dame-de-la-Garde",
  description: "La basilique Notre-Dame-de-la-Garde, souvent surnommée « la Bonne Mère », est une basilique mineure de l'Église catholique datée du xixe siècle. Emblème de Marseille, dédiée à Notre-Dame de la Garde (protectrice de Marseille avec saint Victor), elle domine la ville et la mer Méditerranée depuis le sommet de la colline Notre-Dame-de-la-Garde (site classé depuis 19171).
  Elle se situe à cheval sur les quartiers du Roucas-Blanc et de Vauban, sur un piton calcaire de 149 m d'altitude surélevé de 13 m grâce aux murs et soubassements d'un ancien fort.",
  address: "Notre dame de la Garde, Rue Fort du Sanctuaire, 13006 Marseille"
})
ndlg.photo.attach(io: File.open('./db/seed_pics/ndlg.jpeg'), filename: 'ndlg.jpeg', content_type: 'image/jpeg')
ndlg.save!

corbu = Hotspot.create!({
  name: "Cité radieuse de Marseille",
  description: "Elle est l’œuvre de l’architecte d’origine suisse Charles-Edouard Jeanneret, plus connu sous le nom de Le Corbusier. Première Unité d’Habitation (d’une série de 5), elle a été construite entre 1947 et 1952. Cette cité-jardin verticale, construction sur pilotis d’un ensemble de logements individuels insérés dans une structure collective est conçue comme un laboratoire pour un nouveau “système d’habitat”. La Cité radieuse comporte 337 appartements, de 23 types différents, qui constituent autant de logements confortables et modernes pour l’époque.",
  address: "280 Boulevard Michelet, 13008 Marseille"
})
corbu.photo.attach(io: File.open('./db/seed_pics/corbu.jpeg'), filename: 'corbu.jpeg', content_type: 'image/jpeg')
corbu.save!

charite = Hotspot.create!({
  name: "La Vieille Charité",
  description: "Lieu emblématique de Marseille, la Vieille Charité est nichée au cœur du Panier, le noyau historique de la ville. Merveille de l’architecture du XVIIe siècle, La Vieille Charité symbolise à la fois la richesse du patrimoine marseillais et offre à la ville un haut lieu culturel. Restaurée, la Vieille Charité est devenue, depuis 1986, un centre pluridisciplinaire à vocation scientifique et culturelle de la Ville de Marseille. Elle est classée au titre des Monuments Historiques.",
  address: "2 Rue de la Charité, 13002 Marseille"
})
charite.photo.attach(io: File.open('./db/seed_pics/charite.jpeg'), filename: 'charite.jpeg', content_type: 'image/jpeg')
charite.save!

fortsaintjean = Hotspot.create!({
  name: "Fort Saint-Jean",
  description: "Le Fort Saint Jean est un grand fort situé à l'entrée du Vieux Port de Marseille, face au Palais du Pharo, dans le 2e arrondissement. Pendant les croisades, il était le point de départ des Hospitaliers de Saint Jean pour rejoindre la Terre Sainte. L'ensemble de la construction a été achevée en 1365 mais le Roi René a encore fait édifier la grande tour carrée entre 1447 et 1453. Son but était alors de renforcer la protection du fort. En 1664, des armateurs marseillais construisent la grande tour ronde, très visible dès le premier regard. Appelée Tour Ronde ou Tour du Fanal, elle était utilisée pour observer les va-et-vient des navires de commerce à l'époque.",
  address: "Fort Saint Jean, Quai du Port 13002 Marseille"
})
fortsaintjean.photo.attach(io: File.open('./db/seed_pics/fortsaintjean.jpg'), filename: 'fortsaintjean.jpg', content_type: 'image/jpg')
fortsaintjean.save!

valmer = Hotspot.create!({
  name: "Villa Valmer",
  description: "La villa Valmer est l'une des plus célèbres villas de la corniche du Président-John-Fitzgerald-Kennedy. Située dans le 7e arrondissement de Marseille. Elle se trouve à proximité de plusieurs autres somptueuses villas comme la villa de Gaby Deslys. Composée de trois étages, elle est de style néo-Renaissance. On y trouve aussi un jardin très riche aujourd'hui ouvert au public.",
  address: " 271 corniche du Président-John-Fitzgerald-Kennedy, 13007 Marseille"
})
valmer.photo.attach(io: File.open('./db/seed_pics/valmer.jpeg'), filename: 'valmer.jpeg', content_type: 'image/jpeg')
valmer.save!

invader1= Hotspot.create!({
  name: "Space invader - Corniche",
  description: "Invader est un artiste de rue et mosaïste français, né en France en 1969. Il installe depuis 1996 une série de Space Invaders, réalisés en mosaïques, sur les murs de grandes métropoles internationales.",
  address: "3 Rue des Catalans, 13007 Marseille"
})
invader1.photo.attach(io: File.open('./db/seed_pics/invader1.jpeg'), filename: 'invader1.jpeg', content_type: 'image/jpeg')
invader1.save!

friche = Hotspot.create!({
  name: "La Friche Belle de Mai",
  description: "Lieu de création avec spectacles artistiques, concerts et expos dans une ancienne manufacture des tabacs.",
  address: "41 Rue Jobin, 13003 Marseille"
})
friche.photo.attach(io: File.open('./db/seed_pics/friche.jpg'), filename: 'friche.jpg', content_type: 'image/jpg')
friche.save!

invader2 = Hotspot.create!({
  name: "Space invader - Le Petit Pernod",
  description: "Invader est un artiste de rue et mosaïste français, né en France en 1969. Il installe depuis 1996 une série de Space Invaders, réalisés en mosaïques, sur les murs de grandes métropoles internationales.",
  address: "3 rue des trois rois, 13006 Marseille"
})
invader2.photo.attach(io: File.open('./db/seed_pics/invader2.jpeg'), filename: 'invader2.jpeg', content_type: 'image/jpeg')
invader2.save!

bunker = Hotspot.create!({
  name: "Bunker Von Hanstein",
  description: "Construit fin 1942 par 518 ouvriers du Service de Travail Obligatoire, cet immense bunker sur 7 étages pouvait accueillir plus d'un millier de soldats ! Ce poste de commandement majeur dominait à la fois la rade de Marseille et la vallée de l'Huveaune.",
  address: "Les Trois Ponts, 13010 Marseille"
})
bunker.photo.attach(io: File.open('./db/seed_pics/bunker.jpeg'), filename: 'bunker.jpeg', content_type: 'image/jpeg')
bunker.save!


puts "Creating Categories..."

archi = Category.create!({
  name: "Architecture"
})

street = Category.create!({
  name: "Street Art"
})

pdv = Category.create({
  name: "Point de vue"
})

urbex = Category.create!({
  name: "Urbex"
})

parc = Category.create!({
  name: "Parc"
})

puts "Linking Hotspots to Categories with Hotcat table"

Hotcat.create ({
  hotspot: major,
  category: archi
})

Hotcat.create ({
  hotspot: ndlg,
  category: archi
})

Hotcat.create ({
  hotspot: ndlg,
  category: pdv
})

Hotcat.create ({
  hotspot: corbu,
  category: archi
})

Hotcat.create ({
  hotspot: charite,
  category: archi
})

Hotcat.create ({
  hotspot: fortsaintjean,
  category: archi
})

Hotcat.create ({
  hotspot: fortsaintjean,
  category: pdv
})

Hotcat.create ({
  hotspot: valmer,
  category: parc
})

Hotcat.create ({
  hotspot: valmer,
  category: archi
})

Hotcat.create ({
  hotspot: friche,
  category: street
})

Hotcat.create ({
  hotspot: invader1,
  category: street
})

Hotcat.create ({
  hotspot: invader2,
  category: street
})

Hotcat.create ({
  hotspot: bunker,
  category: urbex
})

puts "Finished!"
