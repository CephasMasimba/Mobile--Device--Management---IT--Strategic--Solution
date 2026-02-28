-- ==========================================
-- IT STRATEGY: MDM DECISION MATRIX (POSTGRESQL)
-- Scenario: Selecting an Endpoint Management Solution for a Professional Services Firm
-- ==========================================

-- 1. SETUP SCHEMA
CREATE SCHEMA IF NOT EXISTS strategy;

-- 2. DEFINE SOLUTIONS
CREATE TABLE strategy.solutions (
    sol_id SERIAL PRIMARY KEY,
    name TEXT UNIQUE,
    tier_focus TEXT,
    base_cost NUMERIC -- Cost for first 50 devices
);

INSERT INTO strategy.solutions (name, tier_focus, base_cost) VALUES
('Platform Alpha', 'SMB / Mid-Market', 0.00),
('Platform Beta', 'Enterprise', 1500.00);

-- 3. DEFINE BUSINESS REQUIREMENTS & WEIGHTS
-- Weights range from 1 (Nice to have) to 5 (Critical)
CREATE TABLE strategy.requirements (
    req_id SERIAL PRIMARY KEY,
    category TEXT,
    requirement TEXT,
    weight INT CHECK (weight BETWEEN 1 AND 5)
);

INSERT INTO strategy.requirements (category, requirement, weight) VALUES
('Cost', 'Minimal Upfront CAPEX', 5),
('Operations', 'Deployment Speed/Ease', 5),
('Technical', 'UEM Capabilities (iOS/Android/Windows)', 4),
('Support', 'Vendor Responsiveness', 4),
('Security', 'Remote Wipe & Compliance', 5);

-- 4. SCORE SOLUTIONS AGAINST REQUIREMENTS
-- Scores range from 1 (Poor) to 10 (Excellent)
CREATE TABLE strategy.evaluations (
    sol_id INT REFERENCES strategy.solutions(sol_id),
    req_id INT REFERENCES strategy.requirements(req_id),
    score INT CHECK (score BETWEEN 1 AND 10),
    PRIMARY KEY (sol_id, req_id)
);

-- Scores for Platform Alpha (Strong on Cost/Ease)
INSERT INTO strategy.evaluations (sol_id, req_id, score) VALUES
(1, 1, 10), -- Cost: Free tier
(1, 2, 9),  -- Ease: Intuitive
(1, 3, 8),  -- Technical: Full UEM
(1, 4, 9),  -- Support: High user rating
(1, 5, 8);  -- Security: Robust

-- Scores for Platform Beta (Strong on Features, but complex/costly)
INSERT INTO strategy.evaluations (sol_id, req_id, score) VALUES
(2, 1, 3),  -- Cost: High entry
(2, 2, 5),  -- Ease: Steep curve
(2, 3, 10), -- Technical: Deep enterprise features
(2, 4, 7),  -- Support: Standard
(2, 5, 9);  -- Security: Enterprise-grade

-- 5. CALCULATE WEIGHTED RECOMMENDATION
CREATE VIEW strategy.recommendation_summary AS
SELECT 
    s.name AS solution,
    ROUND(AVG(e.score), 2) AS raw_avg_score,
    ROUND(SUM(e.score * r.weight)::NUMERIC / SUM(r.weight), 2) AS weighted_score
FROM strategy.solutions s
JOIN strategy.evaluations e ON s.sol_id = e.sol_id
JOIN strategy.requirements r ON e.req_id = r.req_id
GROUP BY s.name
ORDER BY weighted_score DESC;

-- ---------------------------------------------------------
-- EXECUTION: Generate Decision Matrix
-- ---------------------------------------------------------
-- SELECT * FROM strategy.recommendation_summary;
