/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Practica.Andy.dao;

import Practica.Andy.domain.Rol;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author Andy
 */
public interface RolDao extends JpaRepository<Rol, Long> {

}