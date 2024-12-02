// Imports
const jwt = require('jsonwebtoken');
const JWT_SIGN_SECRET = 'Camarades123;';

module.exports = {
    generateTokenForUser: function (userData) {
        return jwt.sign({
            userId: userData.id,
            userEmail: userData.email,
            role: userData.role
        },
        JWT_SIGN_SECRET,
        {
            expiresIn: '1d'
        });
    },
    decodeToken: function(token){
        try{
            return {
                success: true,
                token: jwt.verify(token, JWT_SIGN_SECRET)
            };
        }
        catch(err){
            return {
                success: false,
                error: err
            };
        }

    }
};