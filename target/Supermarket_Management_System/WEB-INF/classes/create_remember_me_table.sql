-- First, add unique constraint to username in users table
ALTER TABLE users ADD UNIQUE INDEX idx_username (username);

-- Create the remember_me_tokens table
CREATE TABLE IF NOT EXISTS remember_me_tokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_token (token),
    INDEX idx_username (username)
);

-- Add the foreign key constraint
ALTER TABLE remember_me_tokens
ADD CONSTRAINT fk_remember_me_username
FOREIGN KEY (username) REFERENCES users(username); 