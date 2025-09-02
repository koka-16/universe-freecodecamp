-- Create database and connect
CREATE DATABASE universe;
\c universe

-- Table: galaxy
CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  type VARCHAR(100) NOT NULL,
  mass NUMERIC,
  age_million_years INT,
  has_bar BOOLEAN NOT NULL,
  description TEXT
);

-- Table: star (references galaxy)
CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  galaxy_id INT NOT NULL,
  spectral_type VARCHAR(10) NOT NULL,
  mass_solar NUMERIC,
  temperature_k INT,
  is_variable BOOLEAN NOT NULL,
  FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
);

-- Table: planet (references star)
CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  star_id INT NOT NULL,
  mass_earth NUMERIC,
  radius_km INT,
  is_habitable BOOLEAN NOT NULL,
  has_rings BOOLEAN NOT NULL,
  composition TEXT,
  FOREIGN KEY (star_id) REFERENCES star(star_id)
);

-- Table: moon (references planet)
CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  planet_id INT NOT NULL,
  mass_kg NUMERIC,
  diameter_km INT,
  is_geologically_active BOOLEAN NOT NULL,
  has_atmosphere BOOLEAN NOT NULL,
  notes TEXT,
  FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
);

-- Table: observation (additional table)
CREATE TABLE observation (
  observation_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  observed_on DATE NOT NULL,
  telescope VARCHAR(200),
  exposure_seconds INT,
  reliable BOOLEAN NOT NULL,
  notes TEXT
);

-- Insert rows into galaxy (at least 6)
INSERT INTO galaxy (name, type, mass, age_million_years, has_bar, description) VALUES
('Milky Way', 'Barred Spiral', 1.5e12, 13600, TRUE, 'Our galaxy'),
('Andromeda', 'Spiral', 1.23e12, 10000, TRUE, 'Nearest large neighbor'),
('Triangulum', 'Spiral', 5.0e10, 12000, FALSE, 'M33'),
('Sombrero', 'Unbarred Spiral', 8.0e11, 9000, FALSE, 'Distinctive dust lane'),
('Large Magellanic Cloud', 'Irregular', 1.5e10, 13000, FALSE, 'Satellite galaxy'),
('Small Magellanic Cloud', 'Irregular', 7.0e9, 15000, FALSE, 'Companion to LMC');

-- Insert rows into star (at least 6, each references a galaxy)
INSERT INTO star (name, galaxy_id, spectral_type, mass_solar, temperature_k, is_variable) VALUES
('Sun', 1, 'G2V', 1.0, 5778, FALSE),
('Proxima Centauri', 1, 'M5.5V', 0.123, 3042, TRUE),
('Sirius A', 1, 'A1V', 2.02, 9940, FALSE),
('Rigil Kentaurus A', 1, 'G2V', 1.1, 5790, FALSE),
('Kepler-22', 1, 'G5', 0.97, 5518, FALSE),
('Andromeda-Alpha', 2, 'F8', 1.2, 6200, FALSE);

-- Insert rows into planet (at least 12, each references a star)
INSERT INTO planet (name, star_id, mass_earth, radius_km, is_habitable, has_rings, composition) VALUES
('Earth', 1, 1.0, 6371, TRUE, FALSE, 'Rocky'),
('Mercury', 1, 0.055, 2440, FALSE, FALSE, 'Rocky'),
('Venus', 1, 0.815, 6052, FALSE, FALSE, 'Rocky'),
('Mars', 1, 0.107, 3389, FALSE, FALSE, 'Rocky'),
('Jupiter', 1, 317.8, 69911, FALSE, TRUE, 'Gas Giant'),
('Saturn', 1, 95.2, 58232, FALSE, TRUE, 'Gas Giant'),
('Uranus', 1, 14.5, 25362, FALSE, TRUE, 'Ice Giant'),
('Neptune', 1, 17.1, 24622, FALSE, TRUE, 'Ice Giant'),
('Proxima b', 2, 1.27, 7000, FALSE, FALSE, 'Rocky'),
('Kepler-22b', 5, 36.0, 20000, FALSE, FALSE, 'Mini-Neptune'),
('Sirius-b-planet1', 3, 0.5, 5000, FALSE, FALSE, 'Rocky'),
('Andromeda-Alpha-1', 6, 5.0, 11000, FALSE, TRUE, 'Super-Earth');

-- Insert rows into moon (at least 20, each references a planet)
INSERT INTO moon (name, planet_id, mass_kg, diameter_km, is_geologically_active, has_atmosphere, notes) VALUES
('Moon', 1, 7.35e22, 3474, FALSE, FALSE, 'Earth''s moon'),
('Phobos', 4, 1.07e16, 22.2, FALSE, FALSE, 'Mars inner moon'),
('Deimos', 4, 1.8e15, 12.6, FALSE, FALSE, 'Mars outer moon'),
('Io', 5, 8.93e22, 3643, TRUE, FALSE, 'Jupiter moon, very active'),
('Europa', 5, 4.8e22, 3122, TRUE, FALSE, 'Subsurface ocean likely'),
('Ganymede', 5, 1.48e23, 5268, FALSE, FALSE, 'Largest moon'),
('Callisto', 5, 1.08e23, 4821, FALSE, FALSE, ''),
('Titan', 6, 1.35e23, 5150, FALSE, TRUE, 'Dense atmosphere'),
('Rhea', 6, 2.31e21, 1528, FALSE, FALSE, ''),
('Iapetus', 6, 1.81e21, 1469, FALSE, FALSE, ''),
('Triton', 8, 2.14e22, 2706, FALSE, TRUE, 'Retrograde orbit'),
('Nereid', 8, 3.1e19, 340, FALSE, FALSE, ''),
('Oberon', 7, 3.0e21, 1523, FALSE, FALSE, ''),
('Titania', 7, 3.53e21, 1578, FALSE, FALSE, ''),
('Ariel', 7, 1.35e21, 1157, FALSE, FALSE, ''),
('Umbriel', 7, 1.27e21, 1169, FALSE, FALSE, ''),
('Charon', 1, 1.52e21, 1212, FALSE, FALSE, 'Pluto''s large moon, placed with Earth''s star''s planet for demo'),
('Callirrhoe', 5, 1.0e16, 8, FALSE, FALSE, ''),
('S/2003 J 12', 5, 7.0e15, 4, FALSE, FALSE, ''),
('Hyperion', 6, 5.6e18, 270, FALSE, FALSE, ''),
('Dione', 6, 1.095e21, 1122, FALSE, FALSE, '';

-- Insert rows into observation (at least 3)
INSERT INTO observation (name, observed_on, telescope, exposure_seconds, reliable, notes) VALUES
('Transit of Kepler-22b', '2011-05-12', 'Kepler', 1800, TRUE, 'Detected transit lightcurve'),
('Proxima flare', '2016-03-18', 'HST', 3600, TRUE, 'Strong flare observed'),
('Andromeda survey', '2018-10-21', 'Large Survey Telescope', 7200, FALSE, 'Preliminary data');
