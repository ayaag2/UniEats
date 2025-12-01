-- UNI EATS INITIAL DATA POPULATION (Real Chicago Restaurants & Universities - 30 Restaurants)
-- Focusing strictly on budget-friendly, ethnic/cultural cuisines near major university campuses.

-- Note: We reset all IDs to ensure clean insertion and update the sequences afterwards.
-- This script should be run after creating the schema (alembic upgrade head).

-- 1. CUISINE INSERTS (16 items)
--------------------------------------------------------------------------------

INSERT INTO cuisine (cuisine_id, name) VALUES
(1, 'American'),
(2, 'Mexican'),
(3, 'Mediterranean'),
(4, 'Italian'),         -- New: Replacing Pizza/Generic Italian-American
(5, 'Asian Fusion'),
(6, 'Japanese'),        -- New: Replacing generic Asian
(7, 'Thai'),
(8, 'Greek'),
(9, 'Middle Eastern'),  -- New: For Halal/Shawarma spots
(10, 'Indian'),
(11, 'Vietnamese'),
(12, 'Ethiopian'),
(13, 'Korean'),
(14, 'Filipino'),
(15, 'South American'), -- Includes Cuban, Peruvian, etc.
(16, 'Caribbean');      -- New (e.g., Jamaican/Haitian)


-- 2. CAMPUS INSERTS (4 items)
--------------------------------------------------------------------------------

INSERT INTO campus (campus_id, name, address, short_label) VALUES
(1, 'University of Illinois Chicago', '1200 W Harrison St, Chicago, IL 60607', 'UIC'),
(2, 'Loyola University Chicago', '1032 W Sheridan Rd, Chicago, IL 60660', 'Loyola'),
(3, 'DePaul University - Loop', '1 E Jackson Blvd, Chicago, IL 60604', 'DePaul'),
(4, 'Northwestern University - Evanston', '633 Clark St, Evanston, IL 60208', 'NU');


-- 3. RESTAURANT INSERTS (30 items - Ethnic & Budget Focused)
--------------------------------------------------------------------------------

INSERT INTO restaurant (restaurant_id, name, price_range, take_out_available, delivery_available, thumbnail_url, cuisine_id) VALUES
-- UIC Focus (1) & Loop Crossover
(1, 'Ghareeb Nawaz', '<$5', TRUE, TRUE, 'https://images.weserv.nl/?url=tb-static.uber.com/prod/image-proc/processed_images/eea8b2c9558d629c09fd441334f4239a/fb86662148be855d931b37d6c1e5fcbe.jpeg&w=200&h=150&fit=cover', 10),
(2, 'Al''s Italian Beef', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=i.ytimg.com/vi/Rj1M6B9f97Q/maxresdefault.jpg&w=200&h=150&fit=cover', 1),
(3, 'Tandoor Char House', '$10-$20', TRUE, TRUE, 'https://images.weserv.nl/?url=https://static.wixstatic.com/media/8df42f_d1b81d8701f4444a80d2994ad8d00542~mv2.jpg/v1/fit/w_2500,h_1330,al_c/8df42f_d1b81d8701f4444a80d2994ad8d00542~mv2.jpg&w=200&h=150&fit=cover', 10),
(4, 'Tacos el Rey', '<$5', TRUE, TRUE, 'https://images.weserv.nl/?url=https://www.chicagotribune.com/wp-content/uploads/migration/2022/02/01/KHCQSLRSHJAZRMO5T4UTNUCCQQ.jpg&w=200&h=150&fit=cover', 2),
(5, 'Pho 888', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=https://tb-static.uber.com/prod/image-proc/processed_images/40b35c9d773b2bb6edc124ed2aec4fde/fb86662148be855d931b37d6c1e5fcbe.jpeg&w=200&h=150&fit=cover', 11),
(6, 'Naf Naf Grill', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=600,height=400,format=auto,quality=80/https://doordash-static.s3.amazonaws.com/media/store/header/14f069d2-d687-4c36-8e6f-0c62bffd6c3b.jpg&w=200&h=150&fit=cover', 9),
(7, 'Jerk Taco Man', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=https://tb-static.uber.com/prod/image-proc/processed_images/7e1c900a9a6e8128e970a18070bdeabf/3ac2b39ad528f8c8c5dc77c59abb683d.jpeg&w=200&h=150&fit=cover', 16),
(8, 'Harold''s Chicken Shack', '$5-$10', TRUE, FALSE, 'https://images.weserv.nl/?url=https://treyschowdown.com/wp-content/uploads/2023/01/Harolds-Chicken-Shack-2-Treys-Chow-Down-.jpg&w=200&h=150&fit=cover', 1),
-- DePaul Loop Focus (3)
(9, 'Cafecito (Loop)', '<$5', TRUE, FALSE, 'https://images.weserv.nl/?url=https://tb-static.uber.com/prod/image-proc/processed_images/f356a08e945f20cfeee1303ddbc55884/783282f6131ef2258e5bcd87c46aa87e.jpeg&w=200&h=150&fit=cover', 15),
(10, 'The Halal Guys (Loop)', '<$5', TRUE, TRUE, 'https://images.weserv.nl/?url=https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7F9wdogPbHNvfk1q28fPYVbioDXpKGx4-IA&s&w=200&h=150&fit=cover', 9),
(11, 'Roti Modern Med (Loop)', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/23/5d/8d/lamb-salad.jpg?w=500&h=-1&s=1&w=200&h=150&fit=cover', 9),
(12, 'Lou Malnati''s (Loop)', '$10-$20', TRUE, TRUE, 'https://images.weserv.nl/?url=https://townsquare.media/site/721/files/2016/05/Lou-Malnatis-Pizza-.jpg?w=780&q=75&w=200&h=150&fit=cover', 4),
(13, 'Burrito Beach (Loop)', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=https://images.getbento.com/accounts/cd384f184db650fd9cb7d98b78d2b3df/media/images/87392BurritoMagn%C3%83fico-9.jpg?w=1200&fit=max&auto=compress,format&cs=origin&w=200&h=150&fit=cover', 2),
(14, 'Saigon Sisters (Loop)', '$10-$20', TRUE, TRUE, 'https://images.weserv.nl/?url=https://static.spotapps.co/spots/51/979565d82c4c2eb04220fe62deeea9/full&w=200&h=150&fit=cover', 11),
(15, 'Ramen-san (Loop)', '$10-$20', TRUE, TRUE, 'https://images.weserv.nl/?url=https://storage.googleapis.com/ramensan_bucket/wp-content/uploads/top.jpg&w=200&h=150&fit=cover', 6),
(16, 'Wow Bao (Loop)', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=https://www.wowbao.com/wp-content/uploads/2024/09/Red-Bao-Portrait.jpg&w=200&h=150&fit=cover', 5),
-- Loyola Focus (2)
(17, 'Banh Mi & Pho (Uptown)', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=https://tb-static.uber.com/prod/image-proc/processed_images/bbe44a7df5c632f420df7f90c61c7818/268ee1a1296808aa6eae11eb597de84d.jpeg&w=200&h=150&fit=cover', 11),
(18, 'Ethiopian Diamond', '$10-$20', TRUE, TRUE, 'https://images.weserv.nl/?url=https://tb-static.uber.com/prod/image-proc/processed_images/079e4e9d3224000c34d9d87f03debcf2/885ba8620d45ab36746a0e8c7b85ee66.jpeg&w=200&h=150&fit=cover', 12),
(19, 'Sarpino''s Piz.', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=https://sarpinosfranchise.com/wp-content/uploads/2023/07/Hotdog-Lifestyle-scaled.jpg&w=200&h=150&fit=cover', 4),
(20, 'Cheesie''s Pub & Grub', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=https://media.timeout.com/images/100894147/750/422/image.jpg&w=200&h=150&fit=cover', 1),
(21, 'Raising Cane''s (Loyola)', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=600,height=400,format=auto,quality=80/https://doordash-static.s3.amazonaws.com/media/store/header/83b88b01-37c1-4c8c-9738-3aecb13d317e.jpg&w=200&h=150&fit=cover', 1),
(22, 'Tacos y Salsa', '<$5', TRUE, TRUE, 'https://images.weserv.nl/?url=https://chicagoparent.nyc3.cdn.digitaloceanspaces.com/wp-content/uploads/2024/06/Photo-credit-%40taco_nano.jpg&w=200&h=150&fit=cover', 2),
(23, 'Felice’s Roman Pizza (Loyola)', '$10-$20', TRUE, TRUE, 'https://images.weserv.nl/?url=www.chicagotribune.com/wp-content/uploads/migration/2017/10/24/VOBLK7CQTBDCRM5V2YEBKOHWIA.jpg?&w=200&h=150&fit=cover', 4),
(24, 'Wakamono Sushi (Loyola)', '$10-$20', TRUE, TRUE, 'https://images.weserv.nl/?url=dynamic-media-cdn.tripadvisor.com/media/photo-o/2c/34/7f/a2/caption.jpg?&w=200&h=150&fit=cover', 6),
(25, 'Joy Yee Noodles (Uptown)', '$10-$20', TRUE, TRUE, 'https://images.weserv.nl/?url=media-cdn.grubhub.com/image/upload/d_search:browse-images:default.jpg/w_1200,q_auto,fl_lossy,dpr_auto,c_fill,f_auto,h_800,g_auto/oqkfnh7bh5uq8vivfjhg&w=200&h=150&fit=cover', 5),
-- Northwestern Focus (4)
(26, 'Kim''s Korean', '$5-$10', TRUE, FALSE, 'https://images.weserv.nl/?url=s3-media0.fl.yelpcdn.com/bphoto/jFs55wL7KSFbJgDoXZveDg/348s.jpg&w=200&h=150&fit=cover', 13),
(27, 'Cozy Noodles & Rice (Evanston)', '$10-$20', TRUE, TRUE, 'https://images.weserv.nl/?url=tb-static.uber.com/prod/image-proc/processed_images/9d99ce3c6ae648d3df0d7550df95f406/c73ecc27d2a9eaa735b1ee95304ba588.jpeg&w=200&h=150&fit=cover', 7),
(28, 'Jollibee (Northwest)', '$5-$10', TRUE, TRUE, 'https://images.weserv.nl/?url=a.mktgcdn.com/p/YX9tzBIULjqISYBAYUwbUgiprwXCVqpTP-Bj_JcTDN4/1280x854.jpg&w=200&h=150&fit=cover', 14),
(29, 'Le Colonial', '$10-$20', TRUE, FALSE, 'https://images.weserv.nl/?url=tb-static.uber.com/prod/image-proc/processed_images/15edb7b934518a73f68b136eaa1b0391/3ac2b39ad528f8c8c5dc77c59abb683d.jpeg&w=200&h=150&fit=cover', 11),
(30, 'Lao Sze Chuan', '$10-$20', TRUE, TRUE, 'https://images.weserv.nl/?url=s3-media0.fl.yelpcdn.com/bphoto/udQ_8orBMpCGMDwlN3npVA/l.jpg&w=200&h=150&fit=cover', 5);


-- 4. CAMPUS PROXIMITY INSERTS (68 items - All <= 2.0 miles)
--------------------------------------------------------------------------------

INSERT INTO campus_proximity (restaurant_id, campus_id, distance_miles) VALUES
-- UIC Focused (1)
(1, 1, 0.8), (1, 3, 1.3),
(2, 1, 0.5), (2, 3, 1.4),
(3, 1, 1.8),
(4, 1, 0.2), (4, 3, 1.5),
(5, 1, 0.9), (5, 3, 1.7),
(6, 1, 1.0), (6, 3, 0.7),
(7, 1, 1.6), (7, 3, 0.8),
(8, 1, 0.3), (8, 3, 1.5),
-- DePaul Loop Focused (3)
(9, 3, 0.2), (9, 1, 1.0),
(10, 3, 0.4), (10, 1, 1.3),
(11, 3, 0.5), (11, 1, 1.4),
(12, 3, 0.5), (12, 1, 1.5),
(13, 3, 0.3), (13, 1, 1.2),
(14, 3, 0.9), (14, 1, 1.9),
(15, 3, 0.1), (15, 1, 1.1),
(16, 3, 0.2), (16, 1, 1.0),
-- Loyola Focused (2)
(17, 2, 0.6), (17, 4, 1.9),
(18, 2, 1.8), (18, 4, 1.5),
(19, 2, 0.9), (19, 4, 1.7),
(20, 2, 1.5),
(21, 2, 0.9),
(22, 2, 1.2),
(23, 2, 0.2),
(24, 2, 0.1),
(25, 2, 0.4),
-- Northwestern Focused (4)
(26, 4, 0.4), (26, 2, 1.8),
(27, 4, 0.2),
(28, 4, 1.9), (28, 2, 1.6),
(29, 4, 0.1), (29, 2, 1.7),
(30, 4, 1.5), (30, 2, 1.4);


-- 5. USER RATING INSERTS (90 sample reviews - 3 per restaurant)
--------------------------------------------------------------------------------

INSERT INTO user_rating (rating_id, restaurant_id, user_name, user_rating, review_text) VALUES
-- UIC Focus
(1, 1, 'Theo', 5, 'Can''t beat the price for authentic Indian food!'),
(2, 1, 'Maya', 4, 'Fast, cheap, and huge portions. The best budget meal near UIC.'),
(3, 1, 'Alex', 5, 'My weekly craving. The chicken tikka is fantastic.'),
(4, 2, 'Chris', 5, 'Best Italian beef in Chicago. Essential stop.'),
(5, 2, 'Sam', 5, 'Dipped and hot is the only way to go. Great UIC landmark.'),
(6, 2, 'Jasmine', 4, 'Quick and messy—a perfect student lunch.'),
(7, 3, 'Priya', 5, 'The best butter chicken near UIC, worth the short walk.'),
(8, 3, 'David', 4, 'Quality Indian food, great for sit-down dinner.'),
(9, 3, 'Kevin', 3, 'A bit pricier than other options, but the ambiance is nice.'),
(10, 4, 'Tom', 4, 'Reliable for quick tacos, the al pastor is fantastic.'),
(11, 4, 'Sarah', 5, 'My go-to late night spot for cheap and fast Mexican.'),
(12, 4, 'Ben', 4, 'Solid street tacos, always friendly service.'),
(13, 5, 'Mark', 5, 'Great pho, huge bowls for the price. Perfect cold-weather meal.'),
(14, 5, 'Nancy', 5, 'Authentic flavors, feels like a quick trip to Vietnam.'),
(15, 5, 'Riley', 4, 'Good portions, but sometimes busy during lunch rush.'),
(16, 6, 'Victor', 5, 'Excellent hummus bowls. Fast, fresh, and healthy.'),
(17, 6, 'Chloe', 5, 'Love the spicy sauce option, perfect for a quick dinner.'),
(18, 6, 'Mina', 4, 'Reliable Mediterranean when I need a quick fix.'),
(19, 7, 'Jake', 5, 'Jerk tacos are a unique and delicious combination.'),
(20, 7, 'Will', 4, 'A must-try Caribbean spot near the campus perimeter.'),
(21, 7, 'Ella', 4, 'Great flavor, but service can be slow during peak hours.'),
(22, 8, 'Lisa', 5, 'A Chicago classic. Greasy, but hits the spot after class.'),
(23, 8, 'John', 4, 'The hot dogs are iconic, super close to UIC dorms.'),
(24, 8, 'Olivia', 5, 'Can''t beat the value and tradition.'),
-- Loop Focus
(25, 9, 'Ryan', 5, 'Best Cuban sandwich in the Loop, fast service.'),
(26, 9, 'Jess', 5, 'Great coffee and a perfect quick breakfast.'),
(27, 9, 'Andrew', 4, 'Love the atmosphere, reliable spot near DePaul.'),
(28, 10, 'Julia', 5, 'The white sauce is legendary. Huge portions for cheap.'),
(29, 10, 'Ethan', 5, 'Go-to spot for street food in the Loop.'),
(30, 10, 'Ava', 4, 'Always a line, but moves quickly. Worth the wait.'),
(31, 11, 'Joe', 5, 'Healthy alternative, quick assembly line style.'),
(32, 11, 'Mia', 4, 'The falafel is excellent and the portions are generous.'),
(33, 11, 'Leo', 4, 'My go-to spot when I need something quick and fresh.'),
(34, 12, 'Noor', 4, 'A Chicago deep-dish essential. Too slow for lunch, perfect for delivery.'),
(35, 12, 'Liam', 4, 'Expensive, but great for when parents visit.'),
(36, 12, 'Zoe', 5, 'The buttercrust is amazing.'),
(37, 13, 'Anna', 4, 'Solid, fast Mexican. Love the sauces and chips.'),
(38, 13, 'Matt', 5, 'Quickest lunch option when studying downtown.'),
(39, 13, 'Henry', 4, 'Always fresh ingredients, great value.'),
(40, 14, 'Eve', 5, 'Authentic Vietnamese food, perfect lunch spot.'),
(41, 14, 'Jack', 4, 'Great pho on a cold day.'),
(42, 14, 'Lucy', 4, 'The spring rolls are highly recommended.'),
(43, 15, 'Aaron', 5, 'Best ramen downtown! Perfect for a cozy meal.'),
(44, 15, 'Grace', 5, 'Spicy miso is my favorite. Student budget friendly if you skip apps.'),
(45, 15, 'Dylan', 4, 'Always busy, but the food is worth the small wait.'),
(46, 16, 'Ken', 4, 'Great spot for a quick bao or noodle bowl.'),
(47, 16, 'Rose', 5, 'The spicy peanut noodles are a must-try.'),
(48, 16, 'Will', 4, 'Excellent value and fast service for Asian Fusion.'),
-- Loyola Focus
(49, 17, 'Jane', 5, 'My weekly pho fix. So close to campus and excellent.'),
(50, 17, 'Peter', 5, 'Excellent value, generous portions, best pho in Rogers Park.'),
(51, 17, 'Quinn', 4, 'The banh mi sandwiches are excellent.'),
(52, 18, 'Nora', 5, 'Great for a group. Delicious vegetarian options.'),
(53, 18, 'Ian', 4, 'Injera is excellent. A different cultural experience near Loyola.'),
(54, 18, 'Mia', 4, 'A nice break from typical college fare, great communal dining.'),
(55, 19, 'Zack', 5, 'Reliable for quick delivery and standard Italian fare.'),
(56, 19, 'Yara', 4, 'Thin crust pizza is excellent.'),
(57, 19, 'Omar', 4, 'Quick delivery is crucial when studying late.'),
(58, 20, 'Gabe', 5, 'Grilled cheese paradise. Open late!'),
(59, 20, 'Hannah', 5, 'The mac-and-cheese sandwich is a game changer.'),
(60, 20, 'Tyler', 4, 'Best post-party food near Loyola.'),
(61, 21, 'Sofie', 5, 'Best chicken tenders in the city, fast service.'),
(62, 21, 'Nick', 5, 'The Cane’s sauce is the reason I go here.'),
(63, 21, 'Kira', 5, 'Fast, reliable, and exactly what you want.'),
(64, 22, 'Luke', 5, 'Authentic Mexican street food, so cheap!'),
(65, 22, 'Eve', 5, 'My go-to for late-night $1 tacos.'),
(66, 22, 'Max', 4, 'Fast and delicious, can’t beat the price.'),
(67, 23, 'Ella', 5, 'My favorite pizza near campus. Authentic Roman style.'),
(68, 23, 'Will', 5, 'Great Roman style crust. Perfect for delivery.'),
(69, 23, 'Jenna', 4, 'A definite step up from chain pizza.'),
(70, 24, 'Don', 4, 'Good quality sushi for the area, usually takeout.'),
(71, 24, 'Lisa', 3, 'Decent, but a bit expensive for a regular meal.'),
(72, 24, 'Hugo', 4, 'Fresh fish, nice staff. Good for a splurge.'),
(73, 25, 'Grace', 5, 'Best Asian Fusion near Loyola, massive portions.'),
(74, 25, 'Frank', 5, 'The bubble tea selection is amazing.'),
(75, 25, 'Chloe', 4, 'Great spot for a group dinner.'),
-- Northwestern Focus
(76, 26, 'Emma', 5, 'Best Korean BBQ in Evanston, super close to dorms.'),
(77, 26, 'Scott', 5, 'Great bulgogi and fast service.'),
(78, 26, 'Kelly', 4, 'Excellent student spot, always busy.'),
(79, 27, 'Min-ji', 5, 'Love the Thai tea and the huge portions of noodles.'),
(80, 27, 'Jeff', 4, 'Always a line, but the food is worth it.'),
(81, 27, 'Erin', 5, 'Great late-night comfort food.'),
(82, 28, 'Devin', 5, 'Filipino comfort food staple, perfect value.'),
(83, 28, 'Katie', 4, 'The Jolly Spaghetti is a must-try! Unique and fun.'),
(84, 28, 'Luke', 4, 'Great value for chicken and rice. A quick option.'),
(85, 29, 'Ria', 4, 'Great French-Vietnamese food. A slightly fancier takeout option.'),
(86, 29, 'Ian', 5, 'Excellent upscale pho and fresh rolls.'),
(87, 29, 'Mia', 4, 'Perfect for parent visits, great location.'),
(88, 30, 'Sue', 4, 'Excellent Szechuan spice, very authentic.'),
(89, 30, 'Peter', 5, 'Best Chinese food in Evanston, highly recommend the mapo tofu.'),
(90, 30, 'Quinn', 4, 'Great spot for a group dinner.');


-- 6. SEQUENCER ADJUSTMENTS
-- Resetting the SERIAL sequences to the max inserted ID to prevent future conflicts.
--------------------------------------------------------------------------------

SELECT setval('cuisine_cuisine_id_seq', (SELECT MAX(cuisine_id) FROM cuisine), true);
SELECT setval('campus_campus_id_seq', (SELECT MAX(campus_id) FROM campus), true);
SELECT setval('restaurant_restaurant_id_seq', (SELECT MAX(restaurant_id) FROM restaurant), true);
SELECT setval('user_rating_rating_id_seq', (SELECT MAX(rating_id) FROM user_rating), true);