const jwtUtils = require('../jwt.utils');

module.exports = {
    /**
     * [Middleware]
     * Permet de savoir si l'utilisateur est connecté
     * ou non ou si son token a expiré
     * @param req
     * @param res
     * @param next
     */
    authenticate: function (req, res, next){
        if(req.cookies.jwt_token == null || req.cookies.jwt_token.length === 0){
            //L'utilisateur n'a pas de token
            res.status(401);
            res.json({
                success: false,
                message: "Vous devez être connecté pour accéder à cette page"
            });
            return;
        }

        let decodedToken = jwtUtils.decodeToken(req.cookies.jwt_token);

        if(decodedToken.success){
            req.user = decodedToken.token;
            // Utilisateur authentifié et token toujours valide
            next();
        }
        else{
            //L'utilisateur n'a pas de token
            res.status(401);
            res.json({
                success: false,
                message: "Vous devez être connecté pour accéder à cette page"
            });
        }
    },
    /**
     * [Middleware]
     * Permet d'autoriser un ou plusieurs roles
     * pour une route
     * @param roles
     * @returns {Function}
     */
    authorize: function(roles = []) {
        return (req, res, next) => {
            let decodedToken = jwtUtils.decodeToken(req.cookies.jwt_token);
            if(decodedToken.success){
                req.user = decodedToken.token;
            }
            else{
                //L'utilisateur n'a pas de token
                res.status(401);
                res.json({
                    success: false,
                    message: "Vous devez être connecté pour accéder à cette page"
                });
                return;
            }

            //Vérification que l'utilisateur possède un des roles demandé par la route
            if (roles.length && !roles.includes(req.user.role)) {
                // Le rôle utilisateur n'est pas suffisant pour cette route
                res.status(403);
                res.json({
                    success: false,
                    message: "Vous n'êtes pas autorisé à accéder à cette fonctionnalité"
                });

                return;
            }

            // L'utilisateur à le droit d'aller sur cette route on l'exécute donc
            next();
        };
    }
};