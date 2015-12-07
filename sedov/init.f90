module init_module

  use datatypes_module
  use probparams_module
  use params_module
  use grid_module
  use variables_module

  implicit none

  private

  public :: init_data

contains
  
  subroutine init_data(U)

    type(gridvar_t), intent(inout) :: U

    integer :: i
    real (kind=dp_t) :: rhoe

    real (kind=dp_t), parameter :: E_sedov = ONE
    real (kind=dp_t) :: p, p_exp, p_amb

    ! we do the balloon method -- find the pressure corresponding to
    ! the energy
    p_exp = (gamma - ONE)*E_sedov/(pi*r_init**2)
    p_amb = 1.e-5_dp_t

    do i = U%grid%lo, U%grid%hi
      
       ! store the conserved state
       U%data(i,iudens) = ONE
       U%data(i,iumomx) = ZERO
       
       if (U%grid%x(i) < r_init) then
          p = p_exp
       else
          p = p_amb
       endif

       rhoe = p/(gamma - ONE)

       U%data(i,iuener) = rhoe
          
    enddo

  end subroutine init_data

end module init_module
