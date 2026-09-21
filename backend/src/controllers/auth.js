import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
import { supabase } from '../config/supabase.js';

dotenv.config();

const JWT_SECRET = process.env.JWT_SECRET;
const JWT_EXPIRES_IN = '7d';

// Validación simple de formato de email
function isValidEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

// Genera un JWT con id y email en el payload
function generateToken(usuario) {
  return jwt.sign({ id: usuario.id, email: usuario.email }, JWT_SECRET, {
    expiresIn: JWT_EXPIRES_IN,
  });
}

// POST /api/auth/register
export async function register(req, res) {
  try {
    const { email, password, nombre } = req.body;

    if (!email || !isValidEmail(email)) {
      return res.status(400).json({ error: 'Email inválido' });
    }

    if (!password || password.length <= 6) {
      return res.status(400).json({ error: 'La contraseña debe tener más de 6 caracteres' });
    }

    // Hasheamos la contraseña, nunca se guarda en texto plano
    const passwordHash = await bcrypt.hash(password, 10);

    const { data: usuario, error } = await supabase
      .from('usuarios')
      .insert({ email, password_hash: passwordHash, nombre: nombre || null })
      .select('id, email, nombre')
      .single();

    if (error) {
      // Código 23505 = violación de restricción UNIQUE (email duplicado)
      if (error.code === '23505') {
        return res.status(409).json({ error: 'Ya existe un usuario con ese email' });
      }
      throw error;
    }

    const token = generateToken(usuario);

    return res.status(201).json({ token, usuario });
  } catch (err) {
    console.error('Error en register:', err.message);
    return res.status(500).json({ error: 'Error al registrar el usuario' });
  }
}

// POST /api/auth/login
export async function login(req, res) {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: 'Email y contraseña son requeridos' });
    }

    const { data: usuario, error } = await supabase
      .from('usuarios')
      .select('id, email, nombre, password_hash')
      .eq('email', email)
      .single();

    // Si no existe el usuario, se responde igual que una contraseña incorrecta
    // (evita revelar si el email está registrado o no)
    if (error || !usuario) {
      return res.status(401).json({ error: 'Credenciales inválidas' });
    }

    const passwordMatch = await bcrypt.compare(password, usuario.password_hash);

    if (!passwordMatch) {
      return res.status(401).json({ error: 'Credenciales inválidas' });
    }

    const token = generateToken(usuario);

    return res.status(200).json({
      token,
      usuario: { id: usuario.id, email: usuario.email, nombre: usuario.nombre },
    });
  } catch (err) {
    console.error('Error en login:', err.message);
    return res.status(500).json({ error: 'Error al iniciar sesión' });
  }
}
