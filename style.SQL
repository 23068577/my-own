-- Création de la base de données
CREATE DATABASE blog_collaboratif;

-- Sélectionner la base de données
USE blog_collaboratif;

-- Créer la table des utilisateurs avec une contrainte de mot de passe sécurisé
CREATE TABLE utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Créer la table des articles
CREATE TABLE articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    contenu TEXT NOT NULL,
    auteur_id INT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (auteur_id) REFERENCES utilisateurs(id) ON DELETE CASCADE
);

-- Créer la table des commentaires
CREATE TABLE commentaires (
    id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    auteur VARCHAR(100) NOT NULL,
    contenu TEXT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);

-- Ajouter un index pour améliorer les performances de recherche sur les emails des utilisateurs
CREATE INDEX idx_email ON utilisateurs(email);

-- Ajouter un index sur l'ID de l'article pour améliorer les performances de recherche de commentaires
CREATE INDEX idx_article_id ON commentaires(article_id);

SELECT articles.id, articles.titre, articles.contenu, utilisateurs.nom AS auteur
FROM articles
JOIN utilisateurs ON articles.auteur_id = utilisateurs.id;

SELECT * FROM commentaires WHERE article_id = 1;

UPDATE articles
SET titre = 'Titre modifié', contenu = 'Contenu mis à jour'
WHERE id = 1;
UPDATE utilisateurs
SET mot_de_passe = 'nouveaumotdepasse123'
WHERE email = 'john.doe@example.com';
DELETE FROM articles WHERE id = 1;
CREATE INDEX idx_auteur_id ON articles(auteur_id);
CREATE INDEX idx_date_creation ON articles(date_creation);
