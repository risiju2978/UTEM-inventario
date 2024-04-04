import React, { useEffect, useState } from 'react';
import { Api } from '../../api/api';
import { useAuthContext } from '../../context/AuthContext';
import { useUserContext } from '../../context/UserAppContext';
import {useNavigate} from 'react-router-dom';

const LoginComponent = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');

    const { login } = useAuthContext()
    const { userSetOnSession } = useUserContext()

    const navigate = useNavigate();

    const handleUsernameChange = (event) => {
        setUsername(event.target.value);
    };

    const handlePasswordChange = (event) => {
        setPassword(event.target.value);
    };

    const handleLogin = () => {
        if(username === '' || password === ''){
            alert('Todos los campos son requeridos');
            return;
        }

        Api.login(username, password)
            .then((response) => {
                console.log('Usuario logueado', response);
                const usuario = response[0];
                if(usuario.user_state === 0){
                    alert('Usuario bloqueado, contacte al administrador del sistema.');
                    return;
                }
                alert('Usuario logueado con exito');
                login();
                userSetOnSession(usuario.user_id, usuario.username, usuario.email, usuario.rol_id);
               navigate('/articulo');
            })
            .catch((error) => {
                console.log('Error al loguear usuario:', error.response.data.message);
                alert(`Error al loguear usuario: ${error.response.data.message}`)
            });
    };

    useEffect(() => {
        if (localStorage.getItem('MY_AUTH_APP') === 'true') {
            navigate('/articulo');
        }
    }, [navigate]);

    return (
        <div className="container">
            <h1>Ingresar al sistema</h1>
            <form>
                <div className="mb-3">
                    <label htmlFor="username" className="form-label">Username</label>
                    <input type="text" className="form-control" id="username" value={username} onChange={handleUsernameChange} />
                </div>
                <div className="mb-3">
                    <label htmlFor="password" className="form-label">Password</label>
                    <input type="password" className="form-control" id="password" value={password} onChange={handlePasswordChange} />
                </div>
                <button type="button" className="btn btn-primary" onClick={handleLogin}>Registrar</button>
            </form>
        </div>
    );
};

export default LoginComponent;