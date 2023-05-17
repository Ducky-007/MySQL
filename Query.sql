-- find the 5 oldest users
SELECT 
    username
FROM
    users
ORDER BY created_at
LIMIT 5;

-- what day of the week do most users register on?

SELECT 
    DAYNAME(created_at) AS day_of_week, COUNT(*) AS total
FROM
    users
GROUP BY day_of_week
ORDER BY total DESC
LIMIT 2;

-- find users who have never posted a photo
SELECT 
    username
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    image_url IS NULL;
    
-- which user and their photo got the most likes
SELECT 
    username, users.id , image_url, photos.id, COUNT(*) AS total_likes
FROM
    photos
        JOIN
    likes ON photos.id = likes.photo_id
        JOIN
    users ON users.id = photos.user_id
GROUP BY photo_id
ORDER BY total_likes DESC
LIMIT 1;

-- how many times does the average user post?
SELECT 
    ROUND((SELECT 
                    COUNT(*)
                FROM
                    photos) / (SELECT 
                    COUNT(*)
                FROM
                    users),
            2) AS avg;
            
-- what are the TOP 5 most common hashtags?
SELECT 
    tag_name, COUNT(*) AS tag_total
FROM
    photos
        JOIN
    photo_tags ON photos.id = photo_tags.photo_id
        JOIN
    tags ON tags.id = photo_tags.tag_id
GROUP BY tag_id
ORDER BY tag_total DESC
LIMIT 5;

-- find users who have liked every single photo on the site
SELECT 
    username, COUNT(*) AS total_likes
FROM
    users
        JOIN
    likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes = (SELECT 
        COUNT(*)
    FROM
        photos);