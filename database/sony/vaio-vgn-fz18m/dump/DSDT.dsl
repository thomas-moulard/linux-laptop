/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20060912
 *
 * Disassembly of DSDT.aml, Mon Jun 16 22:33:51 2008
 *
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x00005C73 (23667)
 *     Revision         0x02
 *     OEM ID           "Sony"
 *     OEM Table ID     "VAIO"
 *     OEM Revision     0x20070418 (537330712)
 *     Creator ID       "PTL "
 *     Creator Revision 0x20050624 (537200164)
 */
DefinitionBlock ("DSDT.aml", "DSDT", 2, "Sony", "VAIO", 0x20070418)
{
    External (PDC1)
    External (PDC0)
    External (CFGD)
    External (^CPU0._PPC)

    OperationRegion (SMI0, SystemMemory, 0x7FEE2B38, 0x00000415)
    Field (SMI0, AnyAcc, NoLock, Preserve)
    {
        BCMD,   8, 
        DID,    32, 
        INFO,   4096
    }

    Field (SMI0, AnyAcc, NoLock, Preserve)
    {
                Offset (0x05), 
        INFB,   8
    }

    Field (SMI0, AnyAcc, NoLock, Preserve)
    {
                Offset (0x05), 
        INFD,   32
    }

    Field (SMI0, AnyAcc, NoLock, Preserve)
    {
                Offset (0x05), 
        INDD,   64
    }

    Field (SMI0, AnyAcc, NoLock, Preserve)
    {
                Offset (0x05), 
        SXBF,   8320
    }

    Field (SMI0, AnyAcc, NoLock, Preserve)
    {
                Offset (0x05), 
        INF1,   8, 
        INF2,   8
    }

    OperationRegion (SMI1, SystemIO, 0x0000FE00, 0x00000002)
    Field (SMI1, AnyAcc, NoLock, Preserve)
    {
        SMIC,   8
    }

    Mutex (MPHS, 0x00)
    Method (PHS0, 1, NotSerialized)
    {
        Store (Arg0, BCMD)
        Store (Zero, SMIC)
        While (LEqual (BCMD, Arg0)) {}
        Store (Zero, BCMD)
    }

    Method (PHS, 1, Serialized)
    {
        Acquire (MPHS, 0xFFFF)
        Store (Zero, DID)
        PHS0 (Arg0)
        Store (INFD, Local0)
        Release (MPHS)
        Return (Local0)
    }

    Method (PHSD, 2, Serialized)
    {
        Acquire (MPHS, 0xFFFF)
        Store (Zero, DID)
        Store (Arg1, INFD)
        PHS0 (Arg0)
        Store (INFD, Local0)
        Release (MPHS)
        Return (Local0)
    }

    Method (PHDD, 2, Serialized)
    {
        Acquire (MPHS, 0xFFFF)
        Store (Zero, DID)
        Store (Arg1, INDD)
        PHS0 (Arg0)
        Store (INDD, Local0)
        Release (MPHS)
        Return (Local0)
    }

    Method (PHSW, 3, Serialized)
    {
        Acquire (MPHS, 0xFFFF)
        Store (Zero, DID)
        Store (Arg1, INF1)
        Store (Arg2, INF2)
        PHS0 (Arg0)
        Store (INFB, Local0)
        Release (MPHS)
        Return (Local0)
    }

    Method (PHSB, 2, Serialized)
    {
        Acquire (MPHS, 0xFFFF)
        Store (Zero, DID)
        Store (Arg1, INFB)
        PHS0 (Arg0)
        Store (INFB, Local0)
        Release (MPHS)
        Return (Local0)
    }

    Mutex (MUTX, 0x00)
    OperationRegion (PRT0, SystemIO, 0x80, 0x04)
    Field (PRT0, DWordAcc, Lock, Preserve)
    {
        P80H,   32
    }

    Method (P8XH, 2, Serialized)
    {
        If (LEqual (Arg0, Zero))
        {
            Store (Or (And (P80D, 0xFFFFFF00), Arg1), P80D)
        }

        If (LEqual (Arg0, One))
        {
            Store (Or (And (P80D, 0xFFFF00FF), ShiftLeft (Arg1, 0x08)
                ), P80D)
        }

        If (LEqual (Arg0, 0x02))
        {
            Store (Or (And (P80D, 0xFF00FFFF), ShiftLeft (Arg1, 0x10)
                ), P80D)
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (Or (And (P80D, 0x00FFFFFF), ShiftLeft (Arg1, 0x18)
                ), P80D)
        }

        Store (P80D, P80H)
    }

    Method (_PIC, 1, NotSerialized)
    {
        Store (Arg0, GPIC)
    }

    Method (_PTS, 1, NotSerialized)
    {
        Store (Zero, P80D)
        P8XH (Zero, Arg0)
        Store (Arg0, PRM0)
        Store (0x51, SMIF)
        Store (Zero, TRP0)
        If (LEqual (Arg0, 0x05))
        {
            \_SB.PHSR (0x4B)
        }
    }

    Method (_WAK, 1, NotSerialized)
    {
        P8XH (One, 0xAB)
        Store (Arg0, PRM0)
        Store (0x52, SMIF)
        Store (Zero, TRP0)
        If (LOr (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
        {
            If (And (CFGD, 0x01000000))
            {
                If (LAnd (And (CFGD, 0xF0), LEqual (OSYS, 0x07D1)))
                {
                    TRAP (0x3D)
                }
            }
        }

        If (LEqual (RP1D, Zero))
        {
            Notify (\_SB.PCI0.RP01, Zero)
        }

        If (LEqual (RP2D, Zero))
        {
            Notify (\_SB.PCI0.RP02, Zero)
        }

        If (LEqual (RP3D, Zero))
        {
            Notify (\_SB.PCI0.RP03, Zero)
        }

        If (LEqual (RP5D, Zero))
        {
            Notify (\_SB.PCI0.RP05, Zero)
        }

        If (LEqual (Arg0, 0x03))
        {
            TRAP (0x46)
            If (LEqual (Zero, ACTT)) {}
        }

        If (_OSI ("Windows 2006"))
        {
            Store (DETC, Local0)
            PHSB (0xE1, Local0)
        }

        Store (\_SB.PCI0.LPCB.EC.RPWR, PWRS)
        Store (\_SB.PCI0.LPCB.EC.RSCL, B0SC)
        Store (\_SB.PCI0.LPCB.EC.BATP, BNUM)
        Notify (\_SB.BAT0, 0x80)
        Notify (\_SB.BAT0, 0x81)
        If (LEqual (Arg0, 0x04))
        {
            Store (CM72, Local0)
            Store (Zero, CM72)
            If (LNotEqual (And (Local0, 0x84, Local0), 0x84))
            {
                Notify (\_SB.PWRB, 0x02)
            }

            If (DTSE)
            {
                TRAP (0x47)
            }
        }
        Else
        {
            If (And (PMST, One))
            {
                Notify (\_SB.PWRB, 0x02)
            }
        }

        \_PR.RPPC ()
        P8XH (Zero, 0xCD)
        Return (Package (0x02)
        {
            Zero, 
            Zero
        })
    }

    Method (GETB, 3, Serialized)
    {
        Multiply (Arg0, 0x08, Local0)
        Multiply (Arg1, 0x08, Local1)
        CreateField (Arg2, Local0, Local1, TBF3)
        Return (TBF3)
    }

    Method (PNOT, 0, Serialized)
    {
        If (MPEN)
        {
            If (And (PDC0, 0x08))
            {
                Notify (\_PR.CPU0, 0x80)
                If (And (PDC0, 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU0, 0x81)
                }
            }

            If (And (PDC1, 0x08))
            {
                Notify (\_PR.CPU1, 0x80)
                If (And (PDC1, 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU1, 0x81)
                }
            }
        }
        Else
        {
            Notify (\_PR.CPU0, 0x80)
            Sleep (0x64)
            Notify (\_PR.CPU0, 0x81)
        }
    }

    Method (TRAP, 1, Serialized)
    {
        Store (Arg0, SMIF)
        Store (Zero, TRP0)
        Return (SMIF)
    }

    Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)
        {
            If (DTSE)
            {
                TRAP (0x47)
            }

            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (One, LINX)
                }

                If (_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    Store (0x07D1, OSYS)
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    Store (0x07D2, OSYS)
                }

                If (_OSI ("Windows 2006"))
                {
                    Store (0x07D6, OSYS)
                }
            }

            If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
            {
                TRAP (0x3D)
            }

            TRAP (0x2B)
            TRAP (0x32)
        }
    }

    OperationRegion (GNVS, SystemMemory, 0x7FEE2A37, 0x0100)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16, 
        SMIF,   8, 
        PRM0,   8, 
        PRM1,   8, 
        SCIF,   8, 
        PRM2,   16, 
        LCKF,   8, 
        PRM4,   16, 
        P80D,   32, 
        LIDS,   8, 
        PWRS,   8, 
        DBGS,   8, 
        LINX,   8, 
                Offset (0x14), 
        ACT1,   8, 
        ACTT,   8, 
        PSVT,   8, 
        TC1V,   8, 
        TC2V,   8, 
        TSPV,   8, 
        CRTT,   8, 
        DTSE,   8, 
        DTS1,   8, 
        DTS2,   8, 
        BNUM,   8, 
        B0SC,   8, 
        B1SC,   8, 
        B2SC,   8, 
        B0SS,   8, 
        B1SS,   8, 
        B2SS,   8, 
        LBST,   8, 
        TBST,   8, 
                Offset (0x28), 
        APIC,   8, 
        MPEN,   8, 
        PCP0,   8, 
        PCP1,   8, 
        PPCM,   8, 
                Offset (0x32), 
                Offset (0x3C), 
        IGDS,   8, 
        TLST,   8, 
        CADL,   8, 
        PADL,   8, 
        CSTE,   16, 
        NSTE,   16, 
        SSTE,   16, 
        NDID,   8, 
        DID1,   32, 
        DID2,   32, 
        DID3,   32, 
        DID4,   32, 
        DID5,   32, 
                Offset (0x64), 
        PNID,   8, 
                Offset (0x67), 
        BLCS,   8, 
        BRTL,   8, 
        ALSE,   8, 
        ALAF,   8, 
        LLOW,   8, 
        LHIH,   8, 
                Offset (0x6E), 
        EMAE,   8, 
        EMAP,   16, 
        EMAL,   16, 
                Offset (0x74), 
        MEFE,   8, 
                Offset (0x78), 
        TPMP,   8, 
        TPME,   8, 
                Offset (0x82), 
        GTF0,   112, 
        GTF2,   112, 
        IDEM,   8, 
        GTF1,   112
    }

    Name (DSEN, One)
    Name (ECON, Zero)
    Name (GPIC, Zero)
    Name (CTYP, Zero)
    Name (L01C, Zero)
    Name (VFN0, Zero)
    Name (VFN1, Zero)
    Name (AODV, Zero)
    Name (CADD, Zero)
    Name (PADD, Zero)
    Scope (_GPE)
    {
        Method (_L01, 0, NotSerialized)
        {
            Add (L01C, One, L01C)
            P8XH (Zero, One)
            P8XH (One, L01C)
            If (LAnd (LEqual (RP1D, Zero), \_SB.PCI0.RP01.HPSX))
            {
                Sleep (0x64)
                If (\_SB.PCI0.RP01.PDCX)
                {
                    Store (One, \_SB.PCI0.RP01.PDCX)
                    Store (One, \_SB.PCI0.RP01.HPSX)
                    Notify (\_SB.PCI0.RP01, Zero)
                }
                Else
                {
                    Store (One, \_SB.PCI0.RP01.HPSX)
                }
            }

            If (LAnd (LEqual (RP2D, Zero), \_SB.PCI0.RP02.HPSX))
            {
                Sleep (0x64)
                If (\_SB.PCI0.RP02.PDCX)
                {
                    Store (One, \_SB.PCI0.RP02.PDCX)
                    Store (One, \_SB.PCI0.RP02.HPSX)
                    Notify (\_SB.PCI0.RP02, Zero)
                }
                Else
                {
                    Store (One, \_SB.PCI0.RP02.HPSX)
                }
            }

            If (LAnd (LEqual (RP3D, Zero), \_SB.PCI0.RP03.HPSX))
            {
                Sleep (0x64)
                If (\_SB.PCI0.RP03.PDCX)
                {
                    Store (One, \_SB.PCI0.RP03.PDCX)
                    Store (One, \_SB.PCI0.RP03.HPSX)
                    Notify (\_SB.PCI0.RP03, Zero)
                }
                Else
                {
                    Store (One, \_SB.PCI0.RP03.HPSX)
                }
            }

            If (LAnd (LEqual (RP5D, Zero), \_SB.PCI0.RP05.HPSX))
            {
                Sleep (0x64)
                If (\_SB.PCI0.RP05.PDCX)
                {
                    Store (One, \_SB.PCI0.RP05.PDCX)
                    Store (One, \_SB.PCI0.RP05.HPSX)
                    Notify (\_SB.PCI0.RP05, Zero)
                }
                Else
                {
                    Store (One, \_SB.PCI0.RP05.HPSX)
                }
            }
        }

        Method (_L02, 0, NotSerialized)
        {
            Store (Zero, GPEC)
        }

        Method (_L03, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB1, 0x02)
        }

        Method (_L04, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB2, 0x02)
        }

        Method (_L05, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB5, 0x02)
        }

        Method (_L09, 0, NotSerialized)
        {
            If (\_SB.PCI0.RP01.PSPX)
            {
                Store (One, \_SB.PCI0.RP01.PSPX)
                Store (One, \_SB.PCI0.RP01.PMSX)
                Notify (\_SB.PCI0.RP01, 0x02)
            }

            If (\_SB.PCI0.RP02.PSPX)
            {
                Store (One, \_SB.PCI0.RP02.PSPX)
                Store (One, \_SB.PCI0.RP02.PMSX)
                Notify (\_SB.PCI0.RP02, 0x02)
            }

            If (\_SB.PCI0.RP03.PSPX)
            {
                Store (One, \_SB.PCI0.RP03.PSPX)
                Store (One, \_SB.PCI0.RP03.PMSX)
                Notify (\_SB.PCI0.RP03, 0x02)
            }

            If (\_SB.PCI0.RP05.PSPX)
            {
                Store (One, \_SB.PCI0.RP05.PSPX)
                Store (One, \_SB.PCI0.RP05.PMSX)
                Notify (\_SB.PCI0.RP05, 0x02)
            }
        }

        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.PCIB, 0x02)
        }

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB3, 0x02)
        }

        Method (_L0D, 0, NotSerialized)
        {
            If (\_SB.PCI0.EHC1.PMES)
            {
                Store (One, \_SB.PCI0.EHC1.PMES)
                Notify (\_SB.PCI0.EHC1, 0x02)
            }

            If (\_SB.PCI0.EHC2.PMES)
            {
                Store (One, \_SB.PCI0.EHC2.PMES)
                Notify (\_SB.PCI0.EHC2, 0x02)
            }

            If (\_SB.PCI0.HDEF.PMES)
            {
                Store (One, \_SB.PCI0.HDEF.PMES)
                Notify (\_SB.PCI0.HDEF, 0x02)
            }
        }

        Method (_L0E, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB4, 0x02)
        }

        Method (_L1E, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }
    }

    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00001010, 0x06) {}
        Processor (CPU1, 0x01, 0x00001010, 0x06) {}
        Method (RPPC, 0, NotSerialized)
        {
            If (LEqual (OSYS, 0x07D2))
            {
                If (And (CFGD, One))
                {
                    If (LGreater (^CPU0._PPC, Zero))
                    {
                        Subtract (^CPU0._PPC, One, ^CPU0._PPC)
                        PNOT ()
                        Add (^CPU0._PPC, One, ^CPU0._PPC)
                        PNOT ()
                    }
                    Else
                    {
                        Add (^CPU0._PPC, One, ^CPU0._PPC)
                        PNOT ()
                        Subtract (^CPU0._PPC, One, ^CPU0._PPC)
                        PNOT ()
                    }
                }
            }
        }
    }

    Scope (_TZ)
    {
        ThermalZone (TZ00)
        {
            Method (_CRT, 0, Serialized)
            {
                Return (0x0FA2)
            }

            Method (_TMP, 0, Serialized)
            {
                If (ECON)
                {
                    Store (\_SB.PCI0.LPCB.EC.TS1R, Local0)
                    If (And (Local0, 0x80))
                    {
                        Subtract (Local0, 0x0100, Local0)
                    }

                    Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
                }

                Return (0x0BB8)
            }
        }

        ThermalZone (TZ01)
        {
            Method (_AC0, 0, Serialized)
            {
                Return (Add (0x0AAC, Multiply (ACTT, 0x0A)))
            }

            Method (_AC1, 0, Serialized)
            {
                Return (Add (0x0AAC, Multiply (ACT1, 0x0A)))
            }

            Method (_CRT, 0, Serialized)
            {
                Return (Add (0x0AAC, Multiply (CRTT, 0x0A)))
            }

            Method (_SCP, 1, Serialized)
            {
                Store (Arg0, CTYP)
            }

            Method (_TMP, 0, Serialized)
            {
                If (DTSE)
                {
                    If (LGreaterEqual (DTS1, DTS2))
                    {
                        Return (Add (0x0AAC, Multiply (DTS1, 0x0A)))
                    }

                    Return (Add (0x0AAC, Multiply (DTS2, 0x0A)))
                }

                If (ECON)
                {
                    Store (\_SB.PCI0.LPCB.EC.TS1R, Local0)
                    If (And (Local0, 0x80))
                    {
                        Subtract (Local0, 0x0100, Local0)
                    }

                    Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
                }

                Return (0x0BB8)
            }

            Method (_PSL, 0, Serialized)
            {
                If (MPEN)
                {
                    Return (Package (0x02)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1
                    })
                }

                Return (Package (0x01)
                {
                    \_PR.CPU0
                })
            }

            Method (_PSV, 0, Serialized)
            {
                Return (Add (0x0AAC, Multiply (PSVT, 0x0A)))
            }

            Method (_TC1, 0, Serialized)
            {
                Return (TC1V)
            }

            Method (_TC2, 0, Serialized)
            {
                Return (TC2V)
            }

            Method (_TSP, 0, Serialized)
            {
                Return (TSPV)
            }
        }
    }

    Scope (_SB)
    {
        Device (ADP1)
        {
            Name (_HID, "ACPI0003")
            Method (_PSR, 0, NotSerialized)
            {
                If (LEqual (ECON, Zero))
                {
                    And (PHSB (0xD4, Zero), 0x80, Local0)
                }
                Else
                {
                    Store (^^PCI0.LPCB.EC.RPWR, Local0)
                }

                If (LEqual (Local0, Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (One)
                }
            }

            Method (_PCL, 0, NotSerialized)
            {
                Return (_SB)
            }
        }

        Device (BAT0)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, Zero)
            Method (_STA, 0, NotSerialized)
            {
                Sleep (0x05)
                If (LEqual (ECON, Zero))
                {
                    Store (Zero, Local1)
                }
                Else
                {
                    Store (^^PCI0.LPCB.EC.BATP, Local1)
                }

                If (LEqual (Local1, Zero))
                {
                    Store (0x0F, Local0)
                }
                Else
                {
                    Store (0x1F, Local0)
                }

                Return (Local0)
            }

            Method (_BIF, 0, NotSerialized)
            {
                Name (MULV, Zero)
                Name (BATI, Package (0x0D)
                {
                    Zero, 
                    0x2710, 
                    0x2710, 
                    Zero, 
                    0xFFFFFFFF, 
                    0x03E8, 
                    0x0190, 
                    0x64, 
                    0x64, 
                    "", 
                    "", 
                    "LiOn", 
                    "Sony Corp."
                })
                Store (One, MULV)
                Sleep (0x05)
                If (LEqual (ECON, Zero)) {}
                Else
                {
                    And (^^PCI0.LPCB.EC.OMFH, 0x80, Local0)
                    If (Local0)
                    {
                        Store (Zero, Index (BATI, Zero))
                        Store (0x0A, MULV)
                    }
                    Else
                    {
                        Store (One, Index (BATI, Zero))
                    }

                    Store (^^PCI0.LPCB.EC.BDCH, Local0)
                    Or (ShiftLeft (Local0, 0x08), ^^PCI0.LPCB.EC.BDCL, Local0)
                    Store (Multiply (Local0, MULV), Index (BATI, One))
                    Store (^^PCI0.LPCB.EC.FCCH, Local0)
                    Or (ShiftLeft (Local0, 0x08), ^^PCI0.LPCB.EC.FCCL, Local0)
                    Store (Multiply (Local0, MULV), Index (BATI, 0x02))
                    Store (^^PCI0.LPCB.EC.BAVH, Local0)
                    Or (ShiftLeft (Local0, 0x08), ^^PCI0.LPCB.EC.BAVL, Local0)
                    Store (Multiply (Local0, MULV), Index (BATI, 0x04))
                }

                Return (BATI)
            }

            Method (_BST, 0, NotSerialized)
            {
                Name (PKG0, Package (0x04)
                {
                    0x02, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF
                })
                Sleep (0x05)
                If (LEqual (ECON, Zero)) {}
                Else
                {
                    If (LEqual (^^PCI0.LPCB.EC.CHGE, One))
                    {
                        Store (^^PCI0.LPCB.EC.RSCL, Local0)
                        If (LEqual (Local0, 0x64))
                        {
                            Store (Zero, Index (PKG0, Zero))
                        }
                        Else
                        {
                            Store (0x02, Index (PKG0, Zero))
                        }
                    }
                    Else
                    {
                        Store (One, Index (PKG0, Zero))
                    }

                    Name (MULV, Zero)
                    And (^^PCI0.LPCB.EC.OMFH, 0x80, Local0)
                    If (Local0)
                    {
                        Store (0x0A, MULV)
                    }
                    Else
                    {
                        Store (One, MULV)
                    }

                    Store (^^PCI0.LPCB.EC.BRCH, Local0)
                    Or (ShiftLeft (Local0, 0x08), ^^PCI0.LPCB.EC.BRCL, Local0)
                    Store (Multiply (Local0, MULV), Index (PKG0, 0x02))
                    Store (^^PCI0.LPCB.EC.RSCL, Local2)
                }

                Return (PKG0)
            }

            Method (_PCL, 0, NotSerialized)
            {
                Return (_SB)
            }
        }

        Device (LID0)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Method (_LID, 0, NotSerialized)
            {
                If (ECON)
                {
                    Store (^^PCI0.LPCB.EC.LSTE, Local0)
                }
                Else
                {
                    And (PHSB (0xD4, Zero), 0x20, Local0)
                }

                If (Local0)
                {
                    Return (Zero)
                }
                Else
                {
                    Return (One)
                }
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_PRW, Package (0x02)
            {
                0x1E, 
                0x04
            })
        }

        Mutex (PLOK, 0x00)
        Method (NCPU, 0, NotSerialized)
        {
            Acquire (PLOK, 0xFFFF)
            Notify (\_PR.CPU0, 0x80)
            Sleep (0x64)
            Notify (\_PR.CPU0, 0x81)
            Release (PLOK)
        }

        Device (PCI0)
        {
            Method (_INI, 0, NotSerialized)
            {
                Store (Zero, ^LPCB.SNC.XECR)
                Store (Zero, ^LPCB.SNC.SNBF)
            }

            Method (_S3D, 0, NotSerialized)
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)
            {
                Return (0x02)
            }

            Name (_HID, EisaId ("PNP0A08"))
            Name (_CID, 0x030AD041)
            Name (SUPP, Zero)
            Name (CTRL, Zero)
            Device (MCHC)
            {
                Name (_ADR, Zero)
                OperationRegion (HBUS, PCI_Config, 0x40, 0xC0)
                Field (HBUS, DWordAcc, NoLock, Preserve)
                {
                    EPEN,   1, 
                        ,   11, 
                    EPBR,   20, 
                            Offset (0x08), 
                    MHEN,   1, 
                        ,   13, 
                    MHBR,   18, 
                            Offset (0x20), 
                    PXEN,   1, 
                    PXSZ,   2, 
                        ,   23, 
                    PXBR,   6, 
                            Offset (0x28), 
                    DIEN,   1, 
                        ,   11, 
                    DIBR,   20, 
                            Offset (0x30), 
                    IPEN,   1, 
                        ,   11, 
                    IPBR,   20, 
                            Offset (0x50), 
                        ,   4, 
                    PM0H,   2, 
                            Offset (0x51), 
                    PM1L,   2, 
                        ,   2, 
                    PM1H,   2, 
                            Offset (0x52), 
                    PM2L,   2, 
                        ,   2, 
                    PM2H,   2, 
                            Offset (0x53), 
                    PM3L,   2, 
                        ,   2, 
                    PM3H,   2, 
                            Offset (0x54), 
                    PM4L,   2, 
                        ,   2, 
                    PM4H,   2, 
                            Offset (0x55), 
                    PM5L,   2, 
                        ,   2, 
                    PM5H,   2, 
                            Offset (0x56), 
                    PM6L,   2, 
                        ,   2, 
                    PM6H,   2, 
                            Offset (0x57), 
                        ,   7, 
                    HENA,   1, 
                            Offset (0x62), 
                    TUUD,   16, 
                            Offset (0x70), 
                        ,   4, 
                    TLUD,   12
                }
            }

            Name (BUF0, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    ,, )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000CF7,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000CF8,         // Length
                    ,, , TypeStatic)
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000D00,         // Range Minimum
                    0x0000FFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0000F300,         // Length
                    ,, , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000C3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y00, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C4000,         // Range Minimum
                    0x000C7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y01, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C8000,         // Range Minimum
                    0x000CBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y02, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000CC000,         // Range Minimum
                    0x000CFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y03, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D0000,         // Range Minimum
                    0x000D3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y04, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D4000,         // Range Minimum
                    0x000D7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y05, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D8000,         // Range Minimum
                    0x000DBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y06, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DC000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y07, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E0000,         // Range Minimum
                    0x000E3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y08, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E4000,         // Range Minimum
                    0x000E7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y09, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E8000,         // Range Minimum
                    0x000EBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0A, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EC000,         // Range Minimum
                    0x000EFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0B, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000F0000,         // Range Minimum
                    0x000FFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00010000,         // Length
                    ,, _Y0C, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0xDFFFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    ,, _Y0E, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xF0000000,         // Range Minimum
                    0xFEBFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0EC00000,         // Length
                    ,, _Y0F, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFED40000,         // Range Minimum
                    0xFED44FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    ,, _Y0D, AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, Serialized)
            {
                If (^MCHC.PM1L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y00._LEN, C0LN)
                    Store (Zero, C0LN)
                }

                If (LEqual (^MCHC.PM1L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y00._RW, C0RW)
                    Store (Zero, C0RW)
                }

                If (^MCHC.PM1H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y01._LEN, C4LN)
                    Store (Zero, C4LN)
                }

                If (LEqual (^MCHC.PM1H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y01._RW, C4RW)
                    Store (Zero, C4RW)
                }

                If (^MCHC.PM2L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y02._LEN, C8LN)
                    Store (Zero, C8LN)
                }

                If (LEqual (^MCHC.PM2L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y02._RW, C8RW)
                    Store (Zero, C8RW)
                }

                If (^MCHC.PM2H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y03._LEN, CCLN)
                    Store (Zero, CCLN)
                }

                If (LEqual (^MCHC.PM2H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y03._RW, CCRW)
                    Store (Zero, CCRW)
                }

                If (^MCHC.PM3L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y04._LEN, D0LN)
                    Store (Zero, D0LN)
                }

                If (LEqual (^MCHC.PM3L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y04._RW, D0RW)
                    Store (Zero, D0RW)
                }

                If (^MCHC.PM3H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y05._LEN, D4LN)
                    Store (Zero, D4LN)
                }

                If (LEqual (^MCHC.PM3H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y05._RW, D4RW)
                    Store (Zero, D4RW)
                }

                If (^MCHC.PM4L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y06._LEN, D8LN)
                    Store (Zero, D8LN)
                }

                If (LEqual (^MCHC.PM4L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y06._RW, D8RW)
                    Store (Zero, D8RW)
                }

                If (^MCHC.PM4H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y07._LEN, DCLN)
                    Store (Zero, DCLN)
                }

                If (LEqual (^MCHC.PM4H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y07._RW, DCRW)
                    Store (Zero, DCRW)
                }

                If (^MCHC.PM5L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y08._LEN, E0LN)
                    Store (Zero, E0LN)
                }

                If (LEqual (^MCHC.PM5L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y08._RW, E0RW)
                    Store (Zero, E0RW)
                }

                If (^MCHC.PM5H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y09._LEN, E4LN)
                    Store (Zero, E4LN)
                }

                If (LEqual (^MCHC.PM5H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y09._RW, E4RW)
                    Store (Zero, E4RW)
                }

                If (^MCHC.PM6L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0A._LEN, E8LN)
                    Store (Zero, E8LN)
                }

                If (LEqual (^MCHC.PM6L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0A._RW, E8RW)
                    Store (Zero, E8RW)
                }

                If (^MCHC.PM6H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0B._LEN, ECLN)
                    Store (Zero, ECLN)
                }

                If (LEqual (^MCHC.PM6H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0B._RW, ECRW)
                    Store (Zero, ECRW)
                }

                If (^MCHC.PM0H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0C._LEN, F0LN)
                    Store (Zero, F0LN)
                }

                If (LEqual (^MCHC.PM0H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0C._RW, F0RW)
                    Store (Zero, F0RW)
                }

                If (TPRS)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0D._LEN, TPML)
                    Store (0x5000, TPML)
                }

                CreateDWordField (BUF0, \_SB.PCI0._Y0E._MIN, M1MN)
                CreateDWordField (BUF0, \_SB.PCI0._Y0E._MAX, M1MX)
                CreateDWordField (BUF0, \_SB.PCI0._Y0E._LEN, M1LN)
                CreateDWordField (BUF0, \_SB.PCI0._Y0F._MIN, M2MN)
                CreateDWordField (BUF0, \_SB.PCI0._Y0F._MAX, M2MX)
                CreateDWordField (BUF0, \_SB.PCI0._Y0F._LEN, M2LN)
                ShiftLeft (^MCHC.PXBR, 0x1A, M1MX)
                ShiftRight (0x10000000, ^MCHC.PXSZ, Local0)
                Add (M1MX, Local0, M2MN)
                Add (Subtract (M2MX, M2MN), One, M2LN)
                Subtract (M1MX, One, M1MX)
                ShiftLeft (^MCHC.TLUD, 0x14, M1MN)
                Add (Subtract (M1MX, M1MN), One, M1LN)
                Return (BUF0)
            }

            Method (_PRT, 0, NotSerialized)
            {
                If (GPIC)
                {
                    Return (Package (0x13)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0007FFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0019FFFF, 
                            Zero, 
                            Zero, 
                            0x14
                        }, 

                        Package (0x04)
                        {
                            0x001AFFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001AFFFF, 
                            One, 
                            Zero, 
                            0x15
                        }, 

                        Package (0x04)
                        {
                            0x001AFFFF, 
                            0x02, 
                            Zero, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001BFFFF, 
                            Zero, 
                            Zero, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            Zero, 
                            Zero, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            One, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x02, 
                            Zero, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x03, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            Zero, 
                            Zero, 
                            0x17
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            One, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x02, 
                            Zero, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            Zero, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            One, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x02, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x03, 
                            Zero, 
                            0x10
                        }
                    })
                }
                Else
                {
                    Return (Package (0x13)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            Zero, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            Zero, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0007FFFF, 
                            Zero, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0019FFFF, 
                            Zero, 
                            ^LPCB.LNKE, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001AFFFF, 
                            Zero, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001AFFFF, 
                            One, 
                            ^LPCB.LNKF, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001AFFFF, 
                            0x02, 
                            ^LPCB.LNKC, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001BFFFF, 
                            Zero, 
                            ^LPCB.LNKG, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            Zero, 
                            ^LPCB.LNKB, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            One, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x02, 
                            ^LPCB.LNKC, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x03, 
                            ^LPCB.LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            Zero, 
                            ^LPCB.LNKH, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            One, 
                            ^LPCB.LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x02, 
                            ^LPCB.LNKC, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            Zero, 
                            ^LPCB.LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            One, 
                            ^LPCB.LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x02, 
                            ^LPCB.LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x03, 
                            ^LPCB.LNKA, 
                            Zero
                        }
                    })
                }
            }

            Method (_OSC, 4, NotSerialized)
            {
                CreateDWordField (Arg3, Zero, PSTS)
                CreateDWordField (Arg3, 0x04, PSUP)
                CreateDWordField (Arg3, 0x08, PCNT)
                Store (PSUP, SUPP)
                Store (PCNT, CTRL)
                Name (UID1, Buffer (0x10)
                {
                    /* 0000 */    0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 
                    /* 0008 */    0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66
                })
                If (LEqual (Arg0, Buffer (0x10)
                        {
                            /* 0000 */    0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 
                            /* 0008 */    0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66
                        }))
                {
                    And (CTRL, 0x1D, CTRL)
                    If (LNotEqual (And (SUPP, 0x16), 0x16))
                    {
                        And (CTRL, 0x1E)
                    }

                    If (Not (And (PSTS, One)))
                    {
                        If (And (CTRL, One)) {}
                        If (And (CTRL, 0x04)) {}
                        If (And (CTRL, 0x10)) {}
                    }

                    If (LNotEqual (Arg1, One))
                    {
                        Or (PSTS, 0x08, PSTS)
                        Return (Arg3)
                    }

                    If (LNotEqual (PCNT, CTRL))
                    {
                        Or (PSTS, 0x10, PSTS)
                    }

                    Store (Zero, PCNT)
                    Return (Arg3)
                }
                Else
                {
                    Or (PSTS, 0x04, PSTS)
                    Return (Arg3)
                }
            }

            Device (PDRC)
            {
                Name (_HID, EisaId ("PNP0C02"))
                Name (_UID, One)
                Name (BUF0, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00004000,         // Address Length
                        _Y10)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00004000,         // Address Length
                        _Y11)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00001000,         // Address Length
                        _Y12)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00001000,         // Address Length
                        _Y13)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y14)
                    Memory32Fixed (ReadWrite,
                        0xFED20000,         // Address Base
                        0x00020000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED40000,         // Address Base
                        0x00005000,         // Address Length
                        _Y15)
                    Memory32Fixed (ReadWrite,
                        0xFED45000,         // Address Base
                        0x0004B000,         // Address Length
                        )
                })
                Method (_CRS, 0, Serialized)
                {
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y10._BAS, RBR0)
                    ShiftLeft (^^LPCB.RCBA, 0x0E, RBR0)
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y11._BAS, MBR0)
                    ShiftLeft (^^MCHC.MHBR, 0x0E, MBR0)
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y12._BAS, DBR0)
                    ShiftLeft (^^MCHC.DIBR, 0x0C, DBR0)
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y13._BAS, EBR0)
                    ShiftLeft (^^MCHC.EPBR, 0x0C, EBR0)
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y14._BAS, XBR0)
                    ShiftLeft (^^MCHC.PXBR, 0x1A, XBR0)
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y14._LEN, XSZ0)
                    ShiftRight (0x10000000, ^^MCHC.PXSZ, XSZ0)
                    If (TPRS)
                    {
                        CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y15._LEN, TPML)
                        Store (Zero, TPML)
                    }

                    Return (BUF0)
                }
            }

            Device (PEGP)
            {
                Name (_ADR, 0x00010000)
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKD, 
                                Zero
                            }
                        })
                    }
                }

                Device (NGFX)
                {
                    Name (_ADR, Zero)
                    OperationRegion (NVFX, PCI_Config, Zero, 0x10)
                    Field (NVFX, AnyAcc, NoLock, Preserve)
                    {
                        NVID,   16
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0118)
                    }

                    Name (ERR0, Buffer (0x04)
                    {
                        /* 0000 */    0x00, 0x00, 0x00, 0x00
                    })
                    Name (ERR1, Buffer (0x04)
                    {
                        /* 0000 */    0x01, 0x00, 0x00, 0x80
                    })
                    Name (VER1, Buffer (0x04)
                    {
                        /* 0000 */    0x01, 0x00, 0x00, 0x00
                    })
                    Name (BHW1, Buffer (0x0C)
                    {
                        /* 0000 */    0x00, 0x00, 0x64, 0x00, 0xC8, 0x00, 0x00, 0x00, 
                        /* 0008 */    0x00, 0x00, 0xE8, 0x03
                    })
                    Name (BCL1, Buffer (0x0B)
                    {
                        /* 0000 */    0x64, 0x64, 0x14, 0x18, 0x1D, 0x24, 0x2C, 0x35, 
                        /* 0008 */    0x3F, 0x4C, 0x64
                    })
                    Name (ODID, Buffer (0x10)
                    {
                        /* 0000 */    0x10, 0x01, 0x00, 0x00, 0x00, 0x01, 0x01, 0x00, 
                        /* 0008 */    0x00, 0x02, 0x01, 0x00, 0x20, 0x01, 0x00, 0x00
                    })
                    Method (NVIF, 3, NotSerialized)
                    {
                        If (LEqual (Arg0, One))
                        {
                            Concatenate (ERR0, VER1, Local0)
                            Return (Local0)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x09))
                            {
                                Name (_T_0, Zero)
                                Store (ToInteger (Arg1), _T_0)
                                If (LEqual (_T_0, Zero))
                                {
                                    Store (ERR0, Local1)
                                    Return (Local1)
                                }
                                Else
                                {
                                    If (LEqual (_T_0, One))
                                    {
                                        Name (_T_1, Zero)
                                        Store (ToInteger (PNID), _T_1)
                                        If (LEqual (_T_1, One))
                                        {
                                            Concatenate (ERR0, BHW1, Local1)
                                        }
                                        Else
                                        {
                                            If (LEqual (_T_1, 0x02))
                                            {
                                                Concatenate (ERR0, BHW1, Local1)
                                            }
                                            Else
                                            {
                                                If (LEqual (_T_1, 0x04))
                                                {
                                                    Concatenate (ERR0, BHW1, Local1)
                                                }
                                                Else
                                                {
                                                    If (LEqual (_T_1, 0x05))
                                                    {
                                                        Concatenate (ERR0, BHW1, Local1)
                                                    }
                                                    Else
                                                    {
                                                        Concatenate (ERR0, BHW1, Local1)
                                                    }
                                                }
                                            }
                                        }

                                        Return (Local1)
                                    }
                                    Else
                                    {
                                        If (LEqual (_T_0, 0x02))
                                        {
                                            Store (ERR0, Local1)
                                            Return (Local1)
                                        }
                                        Else
                                        {
                                            If (LEqual (_T_0, 0x03))
                                            {
                                                Name (_T_2, Zero)
                                                Store (ToInteger (PNID), _T_2)
                                                If (LEqual (_T_2, One))
                                                {
                                                    Concatenate (ERR0, BCL1, Local1)
                                                }
                                                Else
                                                {
                                                    If (LEqual (_T_2, 0x02))
                                                    {
                                                        Concatenate (ERR0, BCL1, Local1)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (_T_2, 0x04))
                                                        {
                                                            Concatenate (ERR0, BCL1, Local1)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (_T_2, 0x05))
                                                            {
                                                                Concatenate (ERR0, BCL1, Local1)
                                                            }
                                                            Else
                                                            {
                                                                Concatenate (ERR0, BCL1, Local1)
                                                            }
                                                        }
                                                    }
                                                }

                                                Return (Local1)
                                            }
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x0B))
                                {
                                    If (LEqual (Arg1, One))
                                    {
                                        Concatenate (ERR0, ODID, Local0)
                                        Return (Local0)
                                    }
                                    Else
                                    {
                                        Return (ERR1)
                                    }
                                }
                            }
                        }

                        Return (ERR1)
                    }
                }
            }

            Device (GFX0)
            {
                Name (_ADR, 0x00020000)
                OperationRegion (IGFX, PCI_Config, 0xF0, 0x10)
                Field (IGFX, AnyAcc, NoLock, Preserve)
                {
                            Offset (0x04), 
                    BREG,   8
                }

                Method (_DOS, 1, NotSerialized)
                {
                    Store (And (Arg0, 0x03), DSEN)
                }

                Method (_DOD, 0, NotSerialized)
                {
                    If (LEqual (NDID, One))
                    {
                        Name (TMP1, Package (0x01)
                        {
                            0xFFFFFFFF
                        })
                        Store (Or (0x00010000, DID1), Index (TMP1, Zero))
                        Return (TMP1)
                    }

                    If (LEqual (NDID, 0x02))
                    {
                        Name (TMP2, Package (0x02)
                        {
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Store (Or (0x00010000, DID1), Index (TMP2, Zero))
                        Store (Or (0x00010000, DID2), Index (TMP2, One))
                        Return (TMP2)
                    }

                    If (LEqual (NDID, 0x03))
                    {
                        Name (TMP3, Package (0x03)
                        {
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Store (Or (0x00010000, DID1), Index (TMP3, Zero))
                        Store (Or (0x00010000, DID2), Index (TMP3, One))
                        Store (Or (0x00010000, DID3), Index (TMP3, 0x02))
                        Return (TMP3)
                    }

                    If (LEqual (NDID, 0x04))
                    {
                        Name (TMP4, Package (0x04)
                        {
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Store (Or (0x00010000, DID1), Index (TMP4, Zero))
                        Store (Or (0x00010000, DID2), Index (TMP4, One))
                        Store (Or (0x00010000, DID3), Index (TMP4, 0x02))
                        Store (Or (0x00010000, DID4), Index (TMP4, 0x03))
                        Return (TMP4)
                    }

                    Name (TMP5, Package (0x05)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    })
                    Store (Or (0x00010000, DID1), Index (TMP5, Zero))
                    Store (Or (0x00010000, DID2), Index (TMP5, One))
                    Store (Or (0x00010000, DID3), Index (TMP5, 0x02))
                    Store (Or (0x00010000, DID4), Index (TMP5, 0x03))
                    Store (Or (0x00010000, DID5), Index (TMP5, 0x04))
                    Return (TMP5)
                }

                Device (DD01)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID1))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        TRAP (One)
                        If (And (CSTE, One))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, One))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD02)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID2))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        TRAP (One)
                        If (And (CSTE, 0x02))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x02))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD03)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID3))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        TRAP (One)
                        If (And (CSTE, 0x04))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x04))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD04)
                {
                    Name (RTL1, Buffer (0x09)
                    {
                        /* 0000 */    0x34, 0x3E, 0x4B, 0x5C, 0x6F, 0x86, 0xA0, 0xC3, 
                        /* 0008 */    0xFF
                    })
                    Name (ICL1, Package (0x0B)
                    {
                        0x64, 
                        0x64, 
                        0x04, 
                        0x10, 
                        0x1C, 
                        0x28, 
                        0x34, 
                        0x40, 
                        0x4C, 
                        0x58, 
                        0x64
                    })
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID4))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        TRAP (One)
                        If (And (CSTE, 0x08))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x08))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }

                    Method (_BCL, 0, NotSerialized)
                    {
                        Name (_T_0, Zero)
                        Store (ToInteger (PNID), _T_0)
                        If (LEqual (_T_0, One))
                        {
                            Return (ICL1)
                        }
                        Else
                        {
                            If (LEqual (_T_0, 0x02))
                            {
                                Return (ICL1)
                            }
                            Else
                            {
                                If (LEqual (_T_0, 0x04))
                                {
                                    Return (ICL1)
                                }
                                Else
                                {
                                    If (LEqual (_T_0, 0x05))
                                    {
                                        Return (ICL1)
                                    }
                                    Else
                                    {
                                        Return (ICL1)
                                    }
                                }
                            }
                        }
                    }

                    Method (_BCM, 1, NotSerialized)
                    {
                        Divide (Subtract (Arg0, 0x04), 0x0C, , Local0)
                        Name (_T_0, Zero)
                        Store (ToInteger (PNID), _T_0)
                        If (LEqual (_T_0, One))
                        {
                            Store (DerefOf (Index (RTL1, Local0)), Local0)
                        }
                        Else
                        {
                            If (LEqual (_T_0, 0x02))
                            {
                                Store (DerefOf (Index (RTL1, Local0)), Local0)
                            }
                            Else
                            {
                                If (LEqual (_T_0, 0x04))
                                {
                                    Store (DerefOf (Index (RTL1, Local0)), Local0)
                                }
                                Else
                                {
                                    If (LEqual (_T_0, 0x05))
                                    {
                                        Store (DerefOf (Index (RTL1, Local0)), Local0)
                                    }
                                    Else
                                    {
                                        Store (DerefOf (Index (RTL1, Local0)), Local0)
                                    }
                                }
                            }
                        }

                        Store (Local0, BREG)
                    }
                }

                Device (DD05)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID5))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        TRAP (One)
                        If (And (CSTE, 0x10))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x10))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }
            }

            Scope (\)
            {
                Method (BRTW, 1, Serialized)
                {
                    Store (Arg0, Local1)
                    If (LEqual (ALSE, 0x02))
                    {
                        Store (Divide (Multiply (ALAF, Arg0), 0x64, ), Local1)
                        If (LGreater (Local1, 0x64))
                        {
                            Store (0x64, Local1)
                        }
                    }

                    Store (Divide (Multiply (0xFF, Local1), 0x64, ), Local0)
                    Store (Local0, PRM0)
                    If (LEqual (TRAP (0x12), Zero))
                    {
                        P8XH (0x02, Local0)
                        Store (Arg0, BRTL)
                    }
                }

                Method (HKDS, 1, Serialized)
                {
                    If (LEqual (Zero, And (0x03, DSEN)))
                    {
                        If (LEqual (TRAP (Arg0), Zero))
                        {
                            If (LNotEqual (CADL, PADL))
                            {
                                Store (CADL, PADL)
                                If (LOr (LGreater (OSYS, 0x07D0), LLess (OSYS, 0x07D6)))
                                {
                                    Notify (\_SB.PCI0, Zero)
                                }
                                Else
                                {
                                    Notify (\_SB.PCI0.GFX0, Zero)
                                }

                                Sleep (0x02EE)
                            }

                            Notify (\_SB.PCI0.GFX0, 0x80)
                        }
                    }

                    If (LEqual (One, And (0x03, DSEN)))
                    {
                        If (LEqual (TRAP (Increment (Arg0)), Zero))
                        {
                            Notify (\_SB.PCI0.GFX0, 0x81)
                        }
                    }
                }

                Method (LSDS, 1, Serialized)
                {
                    If (Arg0)
                    {
                        HKDS (0x0C)
                    }
                    Else
                    {
                        HKDS (0x0E)
                    }

                    If (LNotEqual (And (0x03, DSEN), One))
                    {
                        Sleep (0x32)
                        While (LEqual (And (0x03, DSEN), 0x02))
                        {
                            Sleep (0x32)
                        }
                    }
                }

                Method (BRTN, 1, Serialized)
                {
                    If (LEqual (And (DID1, 0x0F00), 0x0400))
                    {
                        Notify (\_SB.PCI0.GFX0.DD01, Arg0)
                    }

                    If (LEqual (And (DID2, 0x0F00), 0x0400))
                    {
                        Notify (\_SB.PCI0.GFX0.DD02, Arg0)
                    }

                    If (LEqual (And (DID3, 0x0F00), 0x0400))
                    {
                        Notify (\_SB.PCI0.GFX0.DD03, Arg0)
                    }

                    If (LEqual (And (DID4, 0x0F00), 0x0400))
                    {
                        Notify (\_SB.PCI0.GFX0.DD04, Arg0)
                    }

                    If (LEqual (And (DID5, 0x0F00), 0x0400))
                    {
                        Notify (\_SB.PCI0.GFX0.DD05, Arg0)
                    }
                }
            }

            Scope (\)
            {
                OperationRegion (IO_T, SystemIO, 0x0800, 0x10)
                Field (IO_T, ByteAcc, NoLock, Preserve)
                {
                            Offset (0x08), 
                    TRP0,   8
                }

                OperationRegion (PMIO, SystemIO, 0x1000, 0x80)
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                            Offset (0x01), 
                    PMST,   8, 
                            Offset (0x42), 
                        ,   1, 
                    GPEC,   1, 
                            Offset (0x64), 
                        ,   9, 
                    SCIS,   1, 
                            Offset (0x66)
                }

                OperationRegion (GPIO, SystemIO, 0x1180, 0x3C)
                Field (GPIO, ByteAcc, NoLock, Preserve)
                {
                    GU00,   8, 
                    GU01,   8, 
                    GU02,   8, 
                    GU03,   8, 
                    GIO0,   8, 
                    GIO1,   8, 
                    GIO2,   8, 
                    GIO3,   8, 
                            Offset (0x0C), 
                        ,   2, 
                    GP02,   1, 
                            Offset (0x0D), 
                        ,   4, 
                    GP12,   1, 
                            Offset (0x0E), 
                        ,   5, 
                    GP21,   1, 
                            Offset (0x0F), 
                        ,   3, 
                    GP27,   1, 
                    GP28,   1, 
                            Offset (0x10), 
                            Offset (0x18), 
                    GB00,   8, 
                    GB01,   8, 
                    GB02,   8, 
                    GB03,   8, 
                            Offset (0x2C), 
                    GIV0,   8, 
                    GIV1,   8, 
                    GIV2,   8, 
                    GIV3,   8, 
                    GU04,   8, 
                    GU05,   8, 
                    GU06,   8, 
                    GU07,   8, 
                    GIO4,   8, 
                    GIO5,   8, 
                    GIO6,   8, 
                    GIO7,   8, 
                        ,   5, 
                    GP37,   1, 
                            Offset (0x39), 
                    GL05,   8, 
                    GL06,   8, 
                    GL07,   8
                }

                OperationRegion (RCRB, SystemMemory, 0xFED1C000, 0x4000)
                Field (RCRB, DWordAcc, Lock, Preserve)
                {
                            Offset (0x1000), 
                            Offset (0x3000), 
                            Offset (0x3404), 
                    HPAS,   2, 
                        ,   5, 
                    HPAE,   1, 
                            Offset (0x3418), 
                        ,   1, 
                    PATD,   1, 
                    SATD,   1, 
                    SMBD,   1, 
                    HDAD,   1, 
                            Offset (0x341A), 
                    RP1D,   1, 
                    RP2D,   1, 
                    RP3D,   1, 
                    RP4D,   1, 
                    RP5D,   1, 
                    RP6D,   1
                }

                OperationRegion (XCMS, SystemIO, 0x72, 0x02)
                Field (XCMS, ByteAcc, NoLock, Preserve)
                {
                    XIND,   8, 
                    XDAT,   8
                }

                IndexField (XIND, XDAT, ByteAcc, NoLock, Preserve)
                {
                            Offset (0x72), 
                    CM72,   8, 
                            Offset (0x76), 
                    DETC,   8
                }

                Name (_S0, Package (0x03)
                {
                    Zero, 
                    Zero, 
                    Zero
                })
                Name (_S3, Package (0x03)
                {
                    0x05, 
                    0x05, 
                    Zero
                })
                Name (_S4, Package (0x03)
                {
                    0x06, 
                    0x06, 
                    Zero
                })
                Name (_S5, Package (0x03)
                {
                    0x07, 
                    0x07, 
                    Zero
                })
                Method (GETP, 1, Serialized)
                {
                    If (LEqual (And (Arg0, 0x09), Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    If (LEqual (And (Arg0, 0x09), 0x08))
                    {
                        Return (0x0384)
                    }

                    ShiftRight (And (Arg0, 0x0300), 0x08, Local0)
                    ShiftRight (And (Arg0, 0x3000), 0x0C, Local1)
                    Return (Multiply (0x1E, Subtract (0x09, Add (Local0, Local1))
                        ))
                }

                Method (GDMA, 5, Serialized)
                {
                    If (Arg0)
                    {
                        If (LAnd (Arg1, Arg4))
                        {
                            Return (0x14)
                        }

                        If (LAnd (Arg2, Arg4))
                        {
                            Return (Multiply (Subtract (0x04, Arg3), 0x0F))
                        }

                        Return (Multiply (Subtract (0x04, Arg3), 0x1E))
                    }

                    Return (0xFFFFFFFF)
                }

                Method (GETT, 1, Serialized)
                {
                    Return (Multiply (0x1E, Subtract (0x09, Add (And (ShiftRight (Arg0, 0x02
                        ), 0x03), And (Arg0, 0x03)))))
                }

                Method (GETF, 3, Serialized)
                {
                    Name (TMPF, Zero)
                    If (Arg0)
                    {
                        Or (TMPF, One, TMPF)
                    }

                    If (And (Arg2, 0x02))
                    {
                        Or (TMPF, 0x02, TMPF)
                    }

                    If (Arg1)
                    {
                        Or (TMPF, 0x04, TMPF)
                    }

                    If (And (Arg2, 0x20))
                    {
                        Or (TMPF, 0x08, TMPF)
                    }

                    If (And (Arg2, 0x4000))
                    {
                        Or (TMPF, 0x10, TMPF)
                    }

                    Return (TMPF)
                }

                Method (SETP, 3, Serialized)
                {
                    If (LGreater (Arg0, 0xF0))
                    {
                        Return (0x08)
                    }
                    Else
                    {
                        If (And (Arg1, 0x02))
                        {
                            If (LAnd (LLessEqual (Arg0, 0x78), And (Arg2, 0x02)))
                            {
                                Return (0x2301)
                            }

                            If (LAnd (LLessEqual (Arg0, 0xB4), And (Arg2, One)))
                            {
                                Return (0x2101)
                            }
                        }

                        Return (0x1001)
                    }
                }

                Method (SDMA, 1, Serialized)
                {
                    If (LLessEqual (Arg0, 0x14))
                    {
                        Return (One)
                    }

                    If (LLessEqual (Arg0, 0x1E))
                    {
                        Return (0x02)
                    }

                    If (LLessEqual (Arg0, 0x2D))
                    {
                        Return (One)
                    }

                    If (LLessEqual (Arg0, 0x3C))
                    {
                        Return (0x02)
                    }

                    If (LLessEqual (Arg0, 0x5A))
                    {
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SETT, 3, Serialized)
                {
                    If (And (Arg1, 0x02))
                    {
                        If (LAnd (LLessEqual (Arg0, 0x78), And (Arg2, 0x02)))
                        {
                            Return (0x0B)
                        }

                        If (LAnd (LLessEqual (Arg0, 0xB4), And (Arg2, One)))
                        {
                            Return (0x09)
                        }
                    }

                    Return (0x04)
                }
            }

            Device (HDEF)
            {
                Name (_ADR, 0x001B0000)
                OperationRegion (HDAR, PCI_Config, 0x4C, 0x10)
                Field (HDAR, WordAcc, NoLock, Preserve)
                {
                    DCKA,   1, 
                            Offset (0x01), 
                    DCKM,   1, 
                        ,   6, 
                    DCKS,   1, 
                            Offset (0x08), 
                        ,   15, 
                    PMES,   1
                }
            }

            Device (RP01)
            {
                Name (_ADR, 0x001C0000)
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                            Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                            Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                            Offset (0x1B), 
                    LSCX,   1, 
                            Offset (0x20), 
                            Offset (0x22), 
                    PSPX,   1, 
                            Offset (0x9C), 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Device (PXSX)
                {
                    Name (_ADR, Zero)
                    Name (_PRW, Package (0x02)
                    {
                        0x09, 
                        0x03
                    })
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKD, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP02)
            {
                Name (_ADR, 0x001C0001)
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                            Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                            Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                            Offset (0x1B), 
                    LSCX,   1, 
                            Offset (0x20), 
                            Offset (0x22), 
                    PSPX,   1, 
                            Offset (0x9C), 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Device (PXSX)
                {
                    Name (_ADR, Zero)
                    Name (_PRW, Package (0x02)
                    {
                        0x09, 
                        0x03
                    })
                }

                Method (_HPP, 0, NotSerialized)
                {
                    Return (Package (0x04)
                    {
                        0x10, 
                        0x40, 
                        One, 
                        Zero
                    })
                }

                Name (PXSX._RMV, One)
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x10
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKA, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP03)
            {
                Name (_ADR, 0x001C0002)
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                            Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                            Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                            Offset (0x1B), 
                    LSCX,   1, 
                            Offset (0x20), 
                            Offset (0x22), 
                    PSPX,   1, 
                            Offset (0x9C), 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Device (PXSX)
                {
                    Name (_ADR, Zero)
                    Name (_PRW, Package (0x02)
                    {
                        0x09, 
                        0x03
                    })
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x11
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKB, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP05)
            {
                Name (_ADR, 0x001C0004)
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                            Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                            Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                            Offset (0x1B), 
                    LSCX,   1, 
                            Offset (0x20), 
                            Offset (0x22), 
                    PSPX,   1, 
                            Offset (0x9C), 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Device (PXSX)
                {
                    Name (_ADR, Zero)
                    Name (_PRW, Package (0x02)
                    {
                        0x09, 
                        0x03
                    })
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKD, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (U1CS, PCI_Config, 0xC4, 0x04)
                Field (U1CS, DWordAcc, NoLock, Preserve)
                {
                    U1EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x03, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U1EN)
                    }
                    Else
                    {
                        Store (Zero, U1EN)
                    }
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (U2CS, PCI_Config, 0xC4, 0x04)
                Field (U2CS, DWordAcc, NoLock, Preserve)
                {
                    U2EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x04, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U2EN)
                    }
                    Else
                    {
                        Store (Zero, U2EN)
                    }
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (U2CS, PCI_Config, 0xC4, 0x04)
                Field (U2CS, DWordAcc, NoLock, Preserve)
                {
                    U3EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x0C, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U3EN)
                    }
                    Else
                    {
                        Store (Zero, U3EN)
                    }
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB4)
            {
                Name (_ADR, 0x001A0000)
                OperationRegion (U4CS, PCI_Config, 0xC4, 0x04)
                Field (U4CS, DWordAcc, NoLock, Preserve)
                {
                    U4EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x0E, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U4EN)
                    }
                    Else
                    {
                        Store (Zero, U4EN)
                    }
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB5)
            {
                Name (_ADR, 0x001A0001)
                OperationRegion (U5CS, PCI_Config, 0xC4, 0x04)
                Field (U5CS, DWordAcc, NoLock, Preserve)
                {
                    U5EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U5EN)
                    }
                    Else
                    {
                        Store (Zero, U5EN)
                    }
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (EHC1)
            {
                Name (_ADR, 0x001D0007)
                OperationRegion (U7CS, PCI_Config, 0x54, 0x04)
                Field (U7CS, DWordAcc, NoLock, Preserve)
                {
                        ,   15, 
                    PMES,   1
                }

                Device (HUB7)
                {
                    Name (_ADR, Zero)
                    Device (PRT1)
                    {
                        Name (_ADR, One)
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)
                    }

                    Device (PRT3)
                    {
                        Name (_ADR, 0x03)
                    }

                    Device (PRT4)
                    {
                        Name (_ADR, 0x04)
                    }

                    Device (PRT5)
                    {
                        Name (_ADR, 0x05)
                    }

                    Device (PRT6)
                    {
                        Name (_ADR, 0x06)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x0D, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (EHC2)
            {
                Name (_ADR, 0x001A0007)
                OperationRegion (UFCS, PCI_Config, 0x54, 0x04)
                Field (UFCS, DWordAcc, NoLock, Preserve)
                {
                        ,   15, 
                    PMES,   1
                }

                Device (HUB7)
                {
                    Name (_ADR, Zero)
                    Device (PRT1)
                    {
                        Name (_ADR, One)
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)
                    }

                    Device (PRT3)
                    {
                        Name (_ADR, 0x03)
                    }

                    Device (PRT4)
                    {
                        Name (_ADR, 0x04)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x0D, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (PCIB)
            {
                Name (_ADR, 0x001E0000)
                Device (CARD)
                {
                    Name (_ADR, 0x00030000)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0B)
                    }
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (Zero)
                    {
                        If (GPIC)
                        {
                            Return (Package (0x10)
                            {
                                Package (0x04)
                                {
                                    0xFFFF, 
                                    Zero, 
                                    Zero, 
                                    0x15
                                }, 

                                Package (0x04)
                                {
                                    0xFFFF, 
                                    One, 
                                    Zero, 
                                    0x16
                                }, 

                                Package (0x04)
                                {
                                    0xFFFF, 
                                    0x02, 
                                    Zero, 
                                    0x17
                                }, 

                                Package (0x04)
                                {
                                    0xFFFF, 
                                    0x03, 
                                    Zero, 
                                    0x14
                                }, 

                                Package (0x04)
                                {
                                    0x0001FFFF, 
                                    Zero, 
                                    Zero, 
                                    0x16
                                }, 

                                Package (0x04)
                                {
                                    0x0001FFFF, 
                                    One, 
                                    Zero, 
                                    0x15
                                }, 

                                Package (0x04)
                                {
                                    0x0001FFFF, 
                                    0x02, 
                                    Zero, 
                                    0x14
                                }, 

                                Package (0x04)
                                {
                                    0x0001FFFF, 
                                    0x03, 
                                    Zero, 
                                    0x17
                                }, 

                                Package (0x04)
                                {
                                    0x0002FFFF, 
                                    Zero, 
                                    Zero, 
                                    0x12
                                }, 

                                Package (0x04)
                                {
                                    0x0002FFFF, 
                                    One, 
                                    Zero, 
                                    0x13
                                }, 

                                Package (0x04)
                                {
                                    0x0002FFFF, 
                                    0x02, 
                                    Zero, 
                                    0x11
                                }, 

                                Package (0x04)
                                {
                                    0x0002FFFF, 
                                    0x03, 
                                    Zero, 
                                    0x10
                                }, 

                                Package (0x04)
                                {
                                    0x0005FFFF, 
                                    Zero, 
                                    Zero, 
                                    0x11
                                }, 

                                Package (0x04)
                                {
                                    0x0005FFFF, 
                                    One, 
                                    Zero, 
                                    0x14
                                }, 

                                Package (0x04)
                                {
                                    0x0005FFFF, 
                                    0x02, 
                                    Zero, 
                                    0x16
                                }, 

                                Package (0x04)
                                {
                                    0x0005FFFF, 
                                    0x03, 
                                    Zero, 
                                    0x15
                                }
                            })
                        }
                        Else
                        {
                            Return (Package (0x10)
                            {
                                Package (0x04)
                                {
                                    0xFFFF, 
                                    Zero, 
                                    ^^LPCB.LNKF, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0xFFFF, 
                                    One, 
                                    ^^LPCB.LNKG, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0xFFFF, 
                                    0x02, 
                                    ^^LPCB.LNKH, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0xFFFF, 
                                    0x03, 
                                    ^^LPCB.LNKE, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0001FFFF, 
                                    Zero, 
                                    ^^LPCB.LNKG, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0001FFFF, 
                                    One, 
                                    ^^LPCB.LNKF, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0001FFFF, 
                                    0x02, 
                                    ^^LPCB.LNKE, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0001FFFF, 
                                    0x03, 
                                    ^^LPCB.LNKH, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0002FFFF, 
                                    Zero, 
                                    ^^LPCB.LNKC, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0002FFFF, 
                                    One, 
                                    ^^LPCB.LNKD, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0002FFFF, 
                                    0x02, 
                                    ^^LPCB.LNKB, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0002FFFF, 
                                    0x03, 
                                    ^^LPCB.LNKA, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0005FFFF, 
                                    Zero, 
                                    ^^LPCB.LNKB, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0005FFFF, 
                                    One, 
                                    ^^LPCB.LNKE, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0005FFFF, 
                                    0x02, 
                                    ^^LPCB.LNKG, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0005FFFF, 
                                    0x03, 
                                    ^^LPCB.LNKF, 
                                    Zero
                                }
                            })
                        }
                    }
                    Else
                    {
                        If (GPIC)
                        {
                            Return (Package (0x03)
                            {
                                Package (0x04)
                                {
                                    0x0003FFFF, 
                                    Zero, 
                                    Zero, 
                                    0x10
                                }, 

                                Package (0x04)
                                {
                                    0x0003FFFF, 
                                    One, 
                                    Zero, 
                                    0x11
                                }, 

                                Package (0x04)
                                {
                                    0x0003FFFF, 
                                    0x02, 
                                    Zero, 
                                    0x12
                                }
                            })
                        }
                        Else
                        {
                            Return (Package (0x03)
                            {
                                Package (0x04)
                                {
                                    0x0003FFFF, 
                                    Zero, 
                                    ^^LPCB.LNKA, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0003FFFF, 
                                    One, 
                                    ^^LPCB.LNKB, 
                                    Zero
                                }, 

                                Package (0x04)
                                {
                                    0x0003FFFF, 
                                    0x02, 
                                    ^^LPCB.LNKC, 
                                    Zero
                                }
                            })
                        }
                    }
                }
            }

            Device (LPCB)
            {
                Name (_ADR, 0x001F0000)
                OperationRegion (LPC0, PCI_Config, 0x40, 0xC0)
                Field (LPC0, AnyAcc, NoLock, Preserve)
                {
                            Offset (0x20), 
                    PARC,   8, 
                    PBRC,   8, 
                    PCRC,   8, 
                    PDRC,   8, 
                            Offset (0x28), 
                    PERC,   8, 
                    PFRC,   8, 
                    PGRC,   8, 
                    PHRC,   8, 
                            Offset (0x40), 
                    IOD0,   8, 
                    IOD1,   8, 
                            Offset (0xB0), 
                    RAEN,   1, 
                        ,   13, 
                    RCBA,   18
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, One)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PARC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLA, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLA, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PARC, 0x0F), IRQ0)
                        Return (RTLA)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PARC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PARC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PBRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLB, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLB, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PBRC, 0x0F), IRQ0)
                        Return (RTLB)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PBRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PBRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PCRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLC, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PCRC, 0x0F), IRQ0)
                        Return (RTLC)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PCRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PCRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PDRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLD, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLD, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PDRC, 0x0F), IRQ0)
                        Return (RTLD)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PDRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PDRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PERC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLE, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLE, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PERC, 0x0F), IRQ0)
                        Return (RTLE)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PERC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PERC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PFRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLF, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLF, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PFRC, 0x0F), IRQ0)
                        Return (RTLF)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PFRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PFRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PGRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLG, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLG, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PGRC, 0x0F), IRQ0)
                        Return (RTLG)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PGRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PGRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PHRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLH, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLH, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PHRC, 0x0F), IRQ0)
                        Return (RTLH)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PHRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PHRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (EC)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BFFR, ResourceTemplate ()
                        {
                            IO (Decode16,
                                0x0062,             // Range Minimum
                                0x0062,             // Range Maximum
                                0x00,               // Alignment
                                0x01,               // Length
                                )
                            IO (Decode16,
                                0x0066,             // Range Minimum
                                0x0066,             // Range Maximum
                                0x00,               // Alignment
                                0x01,               // Length
                                )
                        })
                        Return (BFFR)
                    }

                    OperationRegion (ECF2, EmbeddedControl, Zero, 0xFF)
                    Field (ECF2, ByteAcc, Lock, Preserve)
                    {
                            ,   3, 
                        PRCP,   1, 
                            ,   1, 
                        LSTE,   1, 
                        BATP,   1, 
                        RPWR,   1, 
                            ,   4, 
                        CHGE,   1, 
                        LVDS,   1, 
                            ,   1, 
                        AUAM,   1, 
                        ENR0,   8, 
                        ENR1,   8, 
                        ESR0,   8, 
                        ESR1,   8, 
                        BSTS,   8, 
                        WKSR,   8, 
                                Offset (0x19), 
                        ISID,   8, 
                                Offset (0x20), 
                        BTPL,   8, 
                        BTPH,   8, 
                        BSNL,   8, 
                        BSNH,   8, 
                        BDCL,   8, 
                        BDCH,   8, 
                        BDVL,   8, 
                        BDVH,   8, 
                        BAVL,   8, 
                        BAVH,   8, 
                        BACL,   8, 
                        BACH,   8, 
                        RSCL,   8, 
                        RSCH,   8, 
                        BRCL,   8, 
                        BRCH,   8, 
                        FCCL,   8, 
                        FCCH,   8, 
                            ,   4, 
                        FDCH,   1, 
                        FUCH,   1, 
                        DCHG,   1, 
                        BTIT,   1, 
                        BSTH,   8, 
                        OMFL,   8, 
                        OMFH,   8, 
                        IBMF,   8, 
                        ASSR,   8, 
                                Offset (0x40), 
                        TS1R,   8, 
                        TS1L,   8, 
                        TS2R,   8, 
                        TS2L,   8, 
                        TS3R,   8, 
                        TS3L,   8, 
                        F1FL,   8, 
                        F1FH,   8, 
                        F2FL,   8, 
                        F2FH,   8, 
                        T1U1,   8, 
                        T1U2,   8, 
                        T1U3,   8, 
                        T1U4,   8, 
                        T1U5,   8, 
                        T1U6,   8, 
                        T1U7,   8, 
                        T1D1,   8, 
                        T1D2,   8, 
                        T1D3,   8, 
                        T1L1,   8, 
                        T2R1,   8, 
                        T2U1,   8, 
                        T3L1,   8, 
                        T3L2,   8, 
                                Offset (0x60), 
                        SMBN,   8, 
                        SPTR,   8, 
                        SSTS,   8, 
                        SADR,   8, 
                        SCMD,   8, 
                        SBFR,   256, 
                        SCNT,   8
                    }

                    Method (_REG, 2, NotSerialized)
                    {
                        If (LAnd (LEqual (Arg0, 0x03), LEqual (Arg1, One)))
                        {
                            Store (BATP, BNUM)
                            Store (RSCL, B0SC)
                            Store (RPWR, PWRS)
                            Notify (BAT0, 0x81)
                            PNOT ()
                            Store (Arg1, ECON)
                        }
                    }

                    Name (_GPE, 0x17)
                    Method (_Q21, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x21)
                        Store (RPWR, PWRS)
                        Notify (ADP1, 0x81)
                        Notify (BAT0, 0x80)
                        PNOT ()
                    }

                    Method (_Q22, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x22)
                        Store (RPWR, PWRS)
                        Notify (ADP1, 0x81)
                        Notify (BAT0, 0x80)
                        PNOT ()
                    }

                    Method (_Q23, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x23)
                        Store (RSCL, B0SC)
                        Store (BATP, BNUM)
                        Notify (BAT0, 0x81)
                    }

                    Method (_Q24, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x24)
                        Store (RSCL, B0SC)
                        Store (BATP, BNUM)
                        Notify (BAT0, 0x81)
                    }

                    Method (_Q25, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x25)
                        Store (RSCL, B0SC)
                        Notify (BAT0, 0x80)
                    }

                    Method (_Q26, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x26)
                        Notify (SNC, 0x90)
                    }

                    Method (_Q27, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x27)
                        Notify (SNC, 0x90)
                    }

                    Method (_Q28, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x28)
                        If (_OSI ("Windows 2006"))
                        {
                            If (LEqual (^^^PEGP.NGFX.NVID, 0xFFFF))
                            {
                                Notify (GFX0, 0x81)
                            }
                            Else
                            {
                                Notify (^^^PEGP.NGFX, 0x81)
                            }
                        }
                        Else
                        {
                            Notify (SNC, 0x91)
                        }
                    }

                    Method (_Q29, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x29)
                        Notify (LID0, 0x80)
                    }

                    Method (_Q2A, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x2A)
                        Notify (LID0, 0x80)
                    }

                    Method (_Q2B, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x2B)
                        Notify (SNC, 0x94)
                    }

                    Method (_Q2C, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x2C)
                        Notify (SNC, 0x94)
                    }

                    Method (_Q32, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x32)
                        Notify (PWRB, 0x80)
                    }

                    Method (_Q34, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x34)
                        Notify (\_TZ.TZ00, 0x80)
                        If (MPEN)
                        {
                            Notify (\_TZ.TZ01, 0x80)
                        }
                    }

                    Name (HF1P, 0x81)
                    Name (HF1R, One)
                    Name (HF5P, 0x85)
                    Name (HF5R, 0x05)
                    Name (HF6P, 0x86)
                    Name (HF6R, 0x06)
                    Name (HF7P, 0x87)
                    Name (HF7R, 0x07)
                    Name (HF8P, 0x88)
                    Name (HF8R, 0x08)
                    Name (HF9P, 0x89)
                    Name (HF9R, 0x09)
                    Name (HFAP, 0x8A)
                    Name (HFAR, 0x0A)
                    Name (HFBP, 0x8B)
                    Name (HFBR, 0x0B)
                    Name (HFCP, 0x8C)
                    Name (HFCR, 0x0C)
                    Name (HFDP, 0x8D)
                    Name (HFDR, 0x0D)
                    Name (HS1P, 0x90)
                    Name (HS1R, 0x10)
                    Name (HS2P, 0x91)
                    Name (HS2R, 0x11)
                    Name (HUPP, 0x95)
                    Name (HUPR, 0x15)
                    Name (HDWP, 0x96)
                    Name (HDWR, 0x16)
                    Name (HMUP, 0x97)
                    Name (HMUR, 0x17)
                    Name (HTRP, 0x99)
                    Name (HTRR, 0x19)
                    Name (HCUP, 0x9A)
                    Name (HCUR, 0x1A)
                    Name (HCDP, 0x9B)
                    Name (HCDR, 0x1B)
                    Name (HEJP, 0x9F)
                    Name (HEJR, 0x1F)
                    Name (HAVP, 0xA1)
                    Name (HAVR, 0x21)
                    Method (_Q50, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x50)
                        SECR (HF1P)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q51, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x51)
                        SECR (HF1R)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q58, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x58)
                        SECR (HF5P)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q59, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x59)
                        SECR (HF5R)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q5A, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x5A)
                        SECR (HF6P)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q5B, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x5B)
                        SECR (HF6R)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q5C, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x5C)
                        SECR (HF7P)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q5D, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x5D)
                        SECR (HF7R)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q5E, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x5E)
                        SECR (HF8P)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q5F, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x5F)
                        SECR (HF8R)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q60, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x60)
                        SECR (HF9P)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q61, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x61)
                        SECR (HF9R)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q62, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x62)
                        SECR (HFAP)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q63, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x63)
                        SECR (HFAR)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q64, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x64)
                        SECR (HFBP)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q65, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x65)
                        SECR (HFBR)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q66, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x66)
                        SECR (HFCP)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q67, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x67)
                        SECR (HFCR)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q68, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x68)
                        SECR (HFDP)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q69, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x69)
                        SECR (HFDR)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q7E, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x7E)
                        SECR (HAVP)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q7F, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x7F)
                        SECR (HAVR)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q82, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x82)
                        SECR (HS1P)
                        Notify (SNC, 0x92)
                    }

                    Method (_Q83, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x83)
                        SECR (HS1R)
                        Notify (SNC, 0x92)
                    }

                    Method (SECR, 1, NotSerialized)
                    {
                        Store (Arg0, ^^SNC.XECR)
                    }

                    Method (GECR, 0, NotSerialized)
                    {
                        Return (^^SNC.XECR)
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x01,               // Alignment
                            0x11,               // Length
                            )
                        IO (Decode16,
                            0x0093,             // Range Minimum
                            0x0093,             // Range Maximum
                            0x01,               // Alignment
                            0x0D,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, NotBusMaster, Transfer8_16, )
                            {4}
                    })
                }

                Device (FWHD)
                {
                    Name (_HID, EisaId ("INT0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xFF000000,         // Address Base
                            0x01000000,         // Address Length
                            )
                    })
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (_CID, 0x010CD041)
                    Name (BUF0, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y16)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LGreaterEqual (OSYS, 0x07D1))
                        {
                            If (HPAE)
                            {
                                Return (0x0F)
                            }
                        }
                        Else
                        {
                            If (HPAE)
                            {
                                Return (0x0B)
                            }
                        }

                        Return (Zero)
                    }

                    Method (_CRS, 0, Serialized)
                    {
                        If (HPAE)
                        {
                            CreateDWordField (BUF0, \_SB.PCI0.LPCB.HPET._Y16._BAS, HPT0)
                            If (LEqual (HPAS, One))
                            {
                                Store (0xFED01000, HPT0)
                            }

                            If (LEqual (HPAS, 0x02))
                            {
                                Store (0xFED02000, HPT0)
                            }

                            If (LEqual (HPAS, 0x03))
                            {
                                Store (0xFED03000, HPT0)
                            }
                        }

                        Return (BUF0)
                    }
                }

                Device (IPIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0024,             // Range Minimum
                            0x0024,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0028,             // Range Minimum
                            0x0028,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x002C,             // Range Minimum
                            0x002C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0030,             // Range Minimum
                            0x0030,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0034,             // Range Minimum
                            0x0034,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0038,             // Range Minimum
                            0x0038,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x003C,             // Range Minimum
                            0x003C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A4,             // Range Minimum
                            0x00A4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A8,             // Range Minimum
                            0x00A8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00AC,             // Range Minimum
                            0x00AC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B4,             // Range Minimum
                            0x00B4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B8,             // Range Minimum
                            0x00B8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00BC,             // Range Minimum
                            0x00BC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (LDRC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x02)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x002E,             // Range Minimum
                            0x002E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x004E,             // Range Minimum
                            0x004E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0063,             // Range Minimum
                            0x0063,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0065,             // Range Minimum
                            0x0065,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0067,             // Range Minimum
                            0x0067,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00B2,             // Range Minimum
                            0x00B2,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0680,             // Range Minimum
                            0x0680,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0800,             // Range Minimum
                            0x0800,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x1000,             // Range Minimum
                            0x1000,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x1180,             // Range Minimum
                            0x1180,             // Range Maximum
                            0x01,               // Alignment
                            0x40,               // Length
                            )
                        IO (Decode16,
                            0x1640,             // Range Minimum
                            0x1640,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0xFE00,             // Range Minimum
                            0xFE00,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0xFE80,             // Range Minimum
                            0xFE80,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                }

                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x10,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                }

                Device (SNC)
                {
                    Name (_HID, EisaId ("SNY5001"))
                    Method (_INI, 0, NotSerialized)
                    {
                        If (_OSI ("Windows 2006"))
                        {
                            And (ENMK, 0xFFBF, ENMK)
                            And (SNIA, 0xFFFD, SNIA)
                            Or (SNIA, 0x40, SNIA)
                            Store (DETC, Local0)
                            PHSB (0xE1, Local0)
                        }
                    }

                    Method (PWAK, 0, NotSerialized)
                    {
                        Acquire (PLOK, 0xFFFF)
                        Sleep (0x64)
                        Notify (\_PR.CPU0, 0x80)
                        Sleep (0x64)
                        Notify (\_PR.CPU0, 0x81)
                        Notify (\_PR.CPU1, 0x81)
                        Sleep (0x64)
                        Release (PLOK)
                        Return (Zero)
                    }

                    Method (GWDP, 0, NotSerialized)
                    {
                        Return (ShiftRight (And (PHS (0xDD), 0x40), 0x06))
                    }

                    Name (EVS0, 0x07)
                    Name (EVS1, Zero)
                    Name (EVS2, Zero)
                    Mutex (MSNE, 0x00)
                    Method (GSNE, 1, NotSerialized)
                    {
                        Store (ShiftRight (And (Arg0, 0xFF000000), 0x18), Local1)
                        Store (ShiftRight (And (Arg0, 0x00FF0000), 0x10), Local2)
                        Store (And (Arg0, 0xFFFF), Local3)
                        Acquire (MSNE, 0xFFFF)
                        Store (Zero, Local0)
                        If (LEqual (Local1, Zero))
                        {
                            If (LEqual (Local2, Zero))
                            {
                                Store (And (Arg0, 0xFFFF0000), Local0)
                                Store (Or (Local0, 0x07), Local0)
                            }

                            If (LEqual (Local2, One))
                            {
                                Store (And (Arg0, 0xFFFF0000), Local0)
                                Store (Or (Local0, Zero), Local0)
                            }

                            If (LEqual (Local2, 0x02))
                            {
                                Store (And (Arg0, 0xFFFF0000), Local0)
                                Store (Or (Local0, Zero), Local0)
                            }
                        }
                        Else
                        {
                            If (LEqual (Local1, One))
                            {
                                If (LEqual (Local2, Zero))
                                {
                                    Store (And (Arg0, 0xFFFF0000), Local0)
                                    Store (Or (Local0, EVS0), Local0)
                                }

                                If (LEqual (Local2, One))
                                {
                                    Store (And (Arg0, 0xFFFF0000), Local0)
                                    Store (Or (Local0, EVS1), Local0)
                                }

                                If (LEqual (Local2, 0x02))
                                {
                                    Store (And (Arg0, 0xFFFF0000), Local0)
                                    Store (Or (Local0, EVS2), Local0)
                                }
                            }
                            Else
                            {
                                Store (Ones, Local0)
                            }
                        }

                        Release (MSNE)
                        Return (Local0)
                    }

                    Method (SSNE, 1, NotSerialized)
                    {
                        Store (ShiftRight (And (Arg0, 0xFF000000), 0x18), Local1)
                        Store (ShiftRight (And (Arg0, 0x00FF0000), 0x10), Local2)
                        Store (And (Arg0, 0xFFFF), Local3)
                        Acquire (MSNE, 0xFFFF)
                        Store (Zero, Local0)
                        If (LEqual (Local1, Zero))
                        {
                            If (LEqual (Local2, Zero))
                            {
                                Store (Or (Arg0, EVS0), EVS0)
                            }

                            If (LEqual (Local2, One))
                            {
                                Store (Or (Arg0, EVS1), EVS1)
                            }

                            If (LEqual (Local2, 0x02))
                            {
                                Store (Or (Arg0, EVS2), EVS2)
                            }
                        }
                        Else
                        {
                            If (LEqual (Local1, One))
                            {
                                If (LEqual (Local2, Zero))
                                {
                                    Store (And (EVS0, Not (Arg0)), EVS0)
                                }

                                If (LEqual (Local2, One))
                                {
                                    Store (And (EVS1, Not (Arg0)), EVS1)
                                }

                                If (LEqual (Local2, 0x02))
                                {
                                    Store (And (EVS2, Not (Arg0)), EVS2)
                                }
                            }
                        }

                        Release (MSNE)
                    }

                    Method (CSXB, 1, NotSerialized)
                    {
                        Acquire (MPHS, 0xFFFF)
                        Store (Arg0, SXBF)
                        PHS0 (0xCC)
                        Store (SXBF, Local0)
                        Release (MPHS)
                        Return (Local0)
                    }

                    Method (SODV, 1, NotSerialized)
                    {
                        If (LNotEqual (DSEN, Zero))
                        {
                            Return (Ones)
                        }

                        Store (Arg0, AODV)
                        If (LNot (And (AODV, CADD)))
                        {
                            Store (One, AODV)
                        }

                        If (LNotEqual (CADD, PADD))
                        {
                            Store (CADD, PADD)
                            Notify (PCI0, Zero)
                            Notify (PEGP, Zero)
                            Sleep (0x02EE)
                        }

                        Notify (GFX0, 0x80)
                        Notify (^^^PEGP.NGFX, 0x80)
                        Return (Zero)
                    }

                    Method (GDDI, 0, NotSerialized)
                    {
                        Store (PHS (0xC5), Local0)
                        Store (And (Local0, 0x0F), CADD)
                        Return (Local0)
                    }

                    Method (STCS, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, Zero)) {}
                        If (LEqual (Arg0, One)) {}
                    }

                    Mutex (MIDB, 0x00)
                    Method (RBMF, 1, Serialized)
                    {
                        Acquire (MIDB, 0xFFFF)
                        And (Arg0, 0x00010000, Local0)
                        Store (PHSD (0xDC, Local0), Local0)
                        If (LEqual (Local0, 0x02))
                        {
                            Sleep (0x1388)
                        }

                        Release (MIDB)
                        Return (Local0)
                    }

                    Method (RSBI, 1, Serialized)
                    {
                        Return (Zero)
                    }

                    Method (CBMF, 1, Serialized)
                    {
                        Acquire (MIDB, 0xFFFF)
                        Or (And (Arg0, 0x0001FFFF), 0x02000000, Local0)
                        Store (PHSD (0xDC, Local0), Local0)
                        Release (MIDB)
                        Return (Zero)
                    }

                    Method (EAWK, 1, Serialized)
                    {
                        Acquire (MIDB, 0xFFFF)
                        PHSB (0xD3, Zero)
                        Not (Arg0, Local0)
                        Release (MIDB)
                        Return (Local0)
                    }

                    Name (SNI0, 0x53636E53)
                    Name (SNI1, 0x6F707075)
                    Name (SNI2, 0x64657472)
                    Name (SNI3, 0x0100)
                    Name (SNI4, 0x374A0000)
                    Name (SNIA, 0x40B5)
                    Name (SNDK, 0x2000)
                    Name (SNN0, 0x0101)
                    Name (SNN1, 0x0102)
                    Name (SNN2, 0x0100)
                    Name (XECR, Zero)
                    Name (SNN4, 0x010F)
                    Name (SNN5, 0x0106)
                    Name (SNN6, 0x0113)
                    Name (SNN7, 0x010A)
                    Name (LBSR, Zero)
                    Name (SNND, 0x010D)
                    Name (SNNE, 0x0105)
                    Name (IIR, 0x02)
                    Name (ENMK, 0xFFE8)
                    Name (ENCR, Zero)
                    Name (ESR, Zero)
                    Method (SN00, 1, NotSerialized)
                    {
                        Store (And (Arg0, 0xFF), Local1)
                        If (LEqual (Local1, Zero))
                        {
                            Return (SNI0)
                        }
                        Else
                        {
                            If (LEqual (Local1, One))
                            {
                                Return (SNI1)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x02))
                                {
                                    Return (SNI2)
                                }
                                Else
                                {
                                    If (LEqual (Local1, 0x03))
                                    {
                                        Return (SNI3)
                                    }
                                    Else
                                    {
                                        If (LEqual (Local1, 0x04))
                                        {
                                            Return (SNI4)
                                        }
                                        Else
                                        {
                                            If (LEqual (Local1, 0x10))
                                            {
                                                Store (SNAV (), Local2)
                                                Return (Local2)
                                            }
                                            Else
                                            {
                                                If (LAnd (LGreaterEqual (Local1, 0x20), LLessEqual (Local1, 0x2F)))
                                                {
                                                    Store (SNGN (Local1), Local2)
                                                    Return (Local2)
                                                }
                                                Else
                                                {
                                                    Return (Zero)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Method (SN01, 0, NotSerialized)
                    {
                        Store (PHS (0xD6), Local1)
                        And (Local1, Not (ENMK), Local1)
                        And (ENCR, ENMK, Local2)
                        Or (Local1, Local2, Local1)
                        Return (Local1)
                    }

                    Mutex (SNM0, 0x00)
                    Method (SN02, 1, NotSerialized)
                    {
                        Store (Arg0, Local1)
                        If (LNotEqual (Local1, Zero))
                        {
                            Acquire (SNM0, 0xFFFF)
                            And (Local1, Not (ENMK), Local2)
                            If (LNotEqual (Local2, Zero))
                            {
                                PHSD (0xD7, Local2)
                            }

                            And (Local1, ENMK, Local2)
                            If (LNotEqual (Local2, Zero))
                            {
                                And (ENCR, ENMK, Local3)
                                Or (Local3, Local2, ENCR)
                            }

                            Release (SNM0)
                        }
                    }

                    Method (SN03, 1, NotSerialized)
                    {
                        Store (Arg0, Local1)
                        If (LNotEqual (Local1, Zero))
                        {
                            Acquire (SNM0, 0xFFFF)
                            And (Local1, Not (ENMK), Local2)
                            If (LNotEqual (Local2, Zero))
                            {
                                PHSD (0xD8, Local1)
                            }

                            And (Local1, ENMK, Local2)
                            If (LNotEqual (Local2, Zero))
                            {
                                And (ENCR, ENMK, Local3)
                                And (Local3, Not (Local2), ENCR)
                            }

                            Release (SNM0)
                        }
                    }

                    Method (SN04, 0, NotSerialized)
                    {
                        Store (^^EC.ESR0, Local1)
                        And (Local1, Not (ENMK), Local1)
                        And (ESR, ENMK, Local2)
                        Or (Local1, Local2, Local1)
                        Return (Local1)
                    }

                    Method (SN05, 1, NotSerialized)
                    {
                        Store (Arg0, Local1)
                        If (LNotEqual (Local1, Zero))
                        {
                            And (Local1, Not (ENMK), Local2)
                            If (LNotEqual (Local2, Zero))
                            {
                                PHSD (0xDA, Local1)
                            }

                            And (Local1, ENMK, Local2)
                            If (LNotEqual (Local2, Zero))
                            {
                                And (ESR, ENMK, Local3)
                                And (Local3, Not (Local2), ESR)
                            }
                        }
                    }

                    Mutex (SNM1, 0x00)
                    Name (SNBF, Buffer (0x0410) {})
                    CreateField (SNBF, Zero, 0x20, SNBD)
                    CreateField (SNBF, 0x20, 0x20, SND1)
                    CreateField (SNBF, 0x40, 0x08, SNB8)
                    CreateField (SNBF, 0x10, 0x40, SND8)
                    Method (SN06, 1, NotSerialized)
                    {
                        Store (Arg0, SNBF)
                        Return (SNCM ())
                    }

                    Method (SNCM, 0, NotSerialized)
                    {
                        Acquire (SNM1, 0xFFFF)
                        Store (DerefOf (Index (SNBF, Zero)), Local0)
                        And (Local0, 0x0F, Local0)
                        If (LEqual (Local0, Zero))
                        {
                            SNF0 (SNBF)
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                If (_OSI ("Windows 2006")) {}
                                Else
                                {
                                    SNF1 (SNBF)
                                }
                            }
                            Else
                            {
                                If (LEqual (Local0, 0x02))
                                {
                                    SNF2 (SNBF)
                                }
                                Else
                                {
                                    If (LEqual (Local0, 0x03))
                                    {
                                        SNF3 (SNBF)
                                    }
                                    Else
                                    {
                                        If (LEqual (Local0, 0x04))
                                        {
                                            SNF4 (SNBF)
                                        }
                                        Else
                                        {
                                            If (LEqual (Local0, 0x05))
                                            {
                                                SNF5 (SNBF)
                                            }
                                            Else
                                            {
                                                If (LEqual (Local0, 0x06))
                                                {
                                                    If (_OSI ("Windows 2006"))
                                                    {
                                                        SNF6 (SNBF)
                                                    }
                                                }
                                                Else
                                                {
                                                    If (LEqual (Local0, 0x07))
                                                    {
                                                        SNF7 (SNBF)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (Local0, 0x0C))
                                                        {
                                                            SNFC (SNBF)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (Local0, 0x0E))
                                                            {
                                                                SNFE (SNBF)
                                                            }
                                                            Else
                                                            {
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Release (SNM1)
                        Return (SNBF)
                    }

                    Method (SN07, 1, NotSerialized)
                    {
                        Store (Arg0, Local0)
                        Store (Local0, SNBD)
                        SNCM ()
                        Return (SNBD)
                    }

                    Method (SNF0, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (One, Local1)
                            PHSB (0xD0, Local1)
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                Store (One, Local1)
                                PHSB (0xD1, Local1)
                            }
                            Else
                            {
                            }
                        }

                        Return (SNBF)
                    }

                    Method (SNF1, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (0x02, Local1)
                            PHSB (0xD0, Local1)
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                Store (0x02, Local1)
                                PHSB (0xD1, Local1)
                            }
                            Else
                            {
                            }
                        }

                        Return (SNBF)
                    }

                    Method (SNF2, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (0x04, Local1)
                            PHSB (0xD0, Local1)
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                Store (0x04, Local1)
                                PHSB (0xD1, Local1)
                            }
                            Else
                            {
                                If (LEqual (Local0, 0x02))
                                {
                                    Store (^^EC.GECR (), Local1)
                                    Store (Local1, Index (SNBF, Zero))
                                }
                                Else
                                {
                                }
                            }
                        }
                    }

                    Method (SNF3, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (PHS (0xDB), Local1)
                            And (Local1, One, Local1)
                            XOr (Local1, One, Local1)
                            Store (Local1, Index (SNBF, Zero))
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                Store (DerefOf (Index (SNBF, 0x02)), Local1)
                                And (Local1, One, Local1)
                                XOr (Local1, One, Local1)
                                PHSB (0xCE, Local1)
                            }
                            Else
                            {
                            }
                        }
                    }

                    Method (SNF4, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (PHS (0xDD), Local1)
                            Store (And (Local1, One), Index (SNBF, Zero))
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                Store (PHS (0xDD), Local1)
                                ShiftRight (And (Local1, 0x06), One, Local1)
                                Store (Local1, Index (SNBF, Zero))
                            }
                            Else
                            {
                                If (LEqual (Local0, 0x02))
                                {
                                    Store (DerefOf (Index (SNBF, 0x02)), Local1)
                                    And (Local1, 0x03, Local1)
                                    PHSD (0xDE, Local1)
                                }
                                Else
                                {
                                    If (LEqual (Local0, 0x03))
                                    {
                                        Store (PHS (0xDD), Local1)
                                        ShiftRight (And (Local1, 0x30), 0x04, Local1)
                                        Store (Local1, Index (SNBF, Zero))
                                    }
                                    Else
                                    {
                                        If (LEqual (Local0, 0x04))
                                        {
                                            Store (DerefOf (Index (SNBF, 0x02)), Local1)
                                            And (Local1, 0x03, Local1)
                                            PHSD (0xDF, Local1)
                                        }
                                        Else
                                        {
                                            If (LEqual (Local0, 0x07))
                                            {
                                                ShiftRight (And (Store (SN04 (), Local1), 0x10), 0x04, Local1)
                                                Store (Local1, Index (SNBF, Zero))
                                            }
                                            Else
                                            {
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Return (SNBF)
                    }

                    Method (SNF5, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (^^EC.ISID, Local1)
                            If (LEqual (Local1, 0x02))
                            {
                                Store (0x04, Local1)
                            }
                            Else
                            {
                                Store (Zero, Local1)
                            }

                            Store (Local1, Index (SNBF, Zero))
                        }
                        Else
                        {
                        }
                    }

                    Method (SNF6, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (One, Index (SNBF, Zero))
                        }

                        If (LEqual (Local0, One))
                        {
                            Store (DETC, Index (SNBF, Zero))
                        }

                        If (LEqual (Local0, 0x02))
                        {
                            Store (DerefOf (Index (SNBF, 0x02)), Local0)
                            If (LNotEqual (DETC, Local0))
                            {
                                PHSB (0xE0, Local0)
                            }

                            Store (DETC, Local0)
                            PHSB (0xE1, Local0)
                        }

                        Return (SNBF)
                    }

                    Method (SNF7, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Acquire (MPHS, 0xFFFF)
                            Store (SND8, Local1)
                            Store (PHDD (0xE2, Local1), SND8)
                            Release (MPHS)
                        }
                    }

                    Method (SNFC, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Not (GP21, Local1)
                            And (Local1, One, Local1)
                            Store (Local1, LBSR)
                            Store (Local1, Index (SNBF, Zero))
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                Store (DerefOf (Index (SNBF, 0x02)), Local2)
                                And (Local2, One, Local2)
                                Store (Local2, LBSR)
                                Not (Local2, Local1)
                                And (Local1, One, Local1)
                                Store (Local1, GP21)
                            }
                            Else
                            {
                            }
                        }
                    }

                    Method (SNFD, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (GP02, Local1)
                            And (Local1, One, Local1)
                            Store (Local1, Index (SNBF, Zero))
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                Store (DerefOf (Index (SNBF, 0x02)), Local2)
                                And (Local2, One, Local2)
                                Store (Local2, GP02)
                            }
                            Else
                            {
                            }
                        }
                    }

                    Method (SNFE, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (PHS (0xC7), Local1)
                            And (Local1, 0xFF, Local1)
                            If (LEqual (Local1, 0xFE))
                            {
                                Store (One, Local1)
                            }
                            Else
                            {
                                Store (Zero, Local1)
                            }

                            Store (Local1, Index (SNBF, Zero))
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                Store (DerefOf (Index (SNBF, 0x02)), Local2)
                                And (Local2, One, Local2)
                                If (LEqual (Local2, Zero))
                                {
                                    Store (0xA0, Local3)
                                }
                                Else
                                {
                                    Store (0xA1, Local3)
                                }

                                PHSB (0xC8, Local3)
                            }
                            Else
                            {
                            }
                        }
                    }

                    Method (SNFF, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (SNBF, One)), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (PHSD (0xC9, 0xFF), Local1)
                            If (LEqual (Local1, Zero))
                            {
                                Store (Zero, SNBD)
                            }
                            Else
                            {
                                Store (IIR, SNBD)
                            }
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                Store (DerefOf (Index (SNBF, 0x02)), Local2)
                                If (LEqual (Local2, One))
                                {
                                    Acquire (MPHS, 0xFFFF)
                                    Store (PHSD (0xC9, Zero), Local1)
                                    Store (Local1, SNBD)
                                    Store (PHSD (0xC9, One), Local1)
                                    Store (Local1, SND1)
                                    Store (PHSD (0xC9, 0x02), Local1)
                                    Store (Local1, SNB8)
                                    Release (MPHS)
                                }
                            }
                            Else
                            {
                            }
                        }
                    }

                    Method (SNAV, 0, NotSerialized)
                    {
                        Store (PHS (0xD2), Local0)
                        If (Local0)
                        {
                            Store (SNIA, Local1)
                        }
                        Else
                        {
                            And (SNIA, Not (SNDK), Local1)
                        }

                        Return (Local1)
                    }

                    Method (SNGN, 1, NotSerialized)
                    {
                        Store (And (Arg0, 0x0F), Local1)
                        If (LEqual (Local1, Zero))
                        {
                            Return (SNN0)
                        }
                        Else
                        {
                            If (LEqual (Local1, One))
                            {
                                If (_OSI ("Windows 2006"))
                                {
                                    Return (Zero)
                                }

                                Return (SNN1)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x02))
                                {
                                    Return (SNN2)
                                }
                                Else
                                {
                                    If (LEqual (Local1, 0x04))
                                    {
                                        Return (SNN4)
                                    }
                                    Else
                                    {
                                        If (LEqual (Local1, 0x05))
                                        {
                                            Return (SNN5)
                                        }
                                        Else
                                        {
                                            If (LEqual (Local1, 0x06))
                                            {
                                                If (_OSI ("Windows 2006"))
                                                {
                                                    Return (SNN6)
                                                }

                                                Return (Zero)
                                            }
                                            Else
                                            {
                                                If (LEqual (Local1, 0x07))
                                                {
                                                    Return (SNN7)
                                                }
                                                Else
                                                {
                                                    If (LEqual (Local1, 0x0E))
                                                    {
                                                        Return (SNNE)
                                                    }
                                                    Else
                                                    {
                                                        Return (Zero)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Scope (\_SB)
                {
                    OperationRegion (TCG1, SystemMemory, 0x7FEE2A30, 0x00000007)
                    Field (TCG1, AnyAcc, NoLock, Preserve)
                    {
                        PPRQ,   8, 
                        PPLO,   8, 
                        PPRP,   8, 
                        PPOR,   8, 
                        TPRS,   8, 
                        TPMV,   8, 
                        MOR,    8
                    }

                    Method (PHSR, 1, Serialized)
                    {
                        Store (Arg0, BCMD)
                        Store (Zero, DID)
                        Store (Zero, SMIC)
                        If (LEqual (BCMD, Arg0)) {}
                        Store (Zero, BCMD)
                        Store (Zero, DID)
                        Return (Zero)
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {1}
                    })
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("SNY9001"))
                    Name (_CID, 0x130FD041)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {12}
                    })
                }
            }

            Device (PATA)
            {
                Name (_ADR, 0x001F0001)
                OperationRegion (PACS, PCI_Config, 0x40, 0xC0)
                Field (PACS, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16, 
                            Offset (0x04), 
                    PSIT,   4, 
                            Offset (0x08), 
                    SYNC,   4, 
                            Offset (0x0A), 
                    SDT0,   2, 
                        ,   2, 
                    SDT1,   2, 
                            Offset (0x14), 
                    ICR0,   4, 
                    ICR1,   4, 
                    ICR2,   4, 
                    ICR3,   4, 
                    ICR4,   4, 
                    ICR5,   4
                }

                Device (PRID)
                {
                    Name (_ADR, Zero)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Name (PBUF, Buffer (0x14)
                        {
                            /* 0000 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0010 */    0x00, 0x00, 0x00, 0x00
                        })
                        CreateDWordField (PBUF, Zero, PIO0)
                        CreateDWordField (PBUF, 0x04, DMA0)
                        CreateDWordField (PBUF, 0x08, PIO1)
                        CreateDWordField (PBUF, 0x0C, DMA1)
                        CreateDWordField (PBUF, 0x10, FLAG)
                        Store (GETP (PRIT), PIO0)
                        Store (GDMA (And (SYNC, One), And (ICR3, One), 
                            And (ICR0, One), SDT0, And (ICR1, One)), DMA0)
                        If (LEqual (DMA0, 0xFFFFFFFF))
                        {
                            Store (PIO0, DMA0)
                        }

                        If (And (PRIT, 0x4000))
                        {
                            If (LEqual (And (PRIT, 0x90), 0x80))
                            {
                                Store (0x0384, PIO1)
                            }
                            Else
                            {
                                Store (GETT (PSIT), PIO1)
                            }
                        }
                        Else
                        {
                            Store (0xFFFFFFFF, PIO1)
                        }

                        Store (GDMA (And (SYNC, 0x02), And (ICR3, 0x02), 
                            And (ICR0, 0x02), SDT1, And (ICR1, 0x02)), DMA1)
                        If (LEqual (DMA1, 0xFFFFFFFF))
                        {
                            Store (PIO1, DMA1)
                        }

                        Store (GETF (And (SYNC, One), And (SYNC, 0x02), 
                            PRIT), FLAG)
                        If (And (LEqual (PIO0, 0xFFFFFFFF), LEqual (DMA0, 0xFFFFFFFF)))
                        {
                            Store (0x78, PIO0)
                            Store (0x14, DMA0)
                            Store (0x03, FLAG)
                        }

                        Return (PBUF)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        CreateDWordField (Arg0, Zero, PIO0)
                        CreateDWordField (Arg0, 0x04, DMA0)
                        CreateDWordField (Arg0, 0x08, PIO1)
                        CreateDWordField (Arg0, 0x0C, DMA1)
                        CreateDWordField (Arg0, 0x10, FLAG)
                        If (LEqual (SizeOf (Arg1), 0x0200))
                        {
                            And (PRIT, 0xC0F0, PRIT)
                            And (SYNC, 0x02, SYNC)
                            Store (Zero, SDT0)
                            And (ICR0, 0x02, ICR0)
                            And (ICR1, 0x02, ICR1)
                            And (ICR3, 0x02, ICR3)
                            And (ICR5, 0x02, ICR5)
                            CreateWordField (Arg1, 0x62, W490)
                            CreateWordField (Arg1, 0x6A, W530)
                            CreateWordField (Arg1, 0x7E, W630)
                            CreateWordField (Arg1, 0x80, W640)
                            CreateWordField (Arg1, 0xB0, W880)
                            CreateWordField (Arg1, 0xBA, W930)
                            Or (PRIT, 0x8004, PRIT)
                            If (LAnd (And (FLAG, 0x02), And (W490, 0x0800)))
                            {
                                Or (PRIT, 0x02, PRIT)
                            }

                            Or (PRIT, SETP (PIO0, W530, W640), PRIT)
                            If (And (FLAG, One))
                            {
                                Or (SYNC, One, SYNC)
                                Store (SDMA (DMA0), SDT0)
                                If (LLess (DMA0, 0x1E))
                                {
                                    Or (ICR3, One, ICR3)
                                }

                                If (LLess (DMA0, 0x3C))
                                {
                                    Or (ICR0, One, ICR0)
                                }

                                If (And (W930, 0x2000))
                                {
                                    Or (ICR1, One, ICR1)
                                }
                            }
                        }

                        If (LEqual (SizeOf (Arg2), 0x0200))
                        {
                            And (PRIT, 0xBF0F, PRIT)
                            Store (Zero, PSIT)
                            And (SYNC, One, SYNC)
                            Store (Zero, SDT1)
                            And (ICR0, One, ICR0)
                            And (ICR1, One, ICR1)
                            And (ICR3, One, ICR3)
                            And (ICR5, One, ICR5)
                            CreateWordField (Arg2, 0x62, W491)
                            CreateWordField (Arg2, 0x6A, W531)
                            CreateWordField (Arg2, 0x7E, W631)
                            CreateWordField (Arg2, 0x80, W641)
                            CreateWordField (Arg2, 0xB0, W881)
                            CreateWordField (Arg2, 0xBA, W931)
                            Or (PRIT, 0x8040, PRIT)
                            If (LAnd (And (FLAG, 0x08), And (W491, 0x0800)))
                            {
                                Or (PRIT, 0x20, PRIT)
                            }

                            If (And (FLAG, 0x10))
                            {
                                Or (PRIT, 0x4000, PRIT)
                                If (LGreater (PIO1, 0xF0))
                                {
                                    Or (PRIT, 0x80, PRIT)
                                }
                                Else
                                {
                                    Or (PRIT, 0x10, PRIT)
                                    Store (SETT (PIO1, W531, W641), PSIT)
                                }
                            }

                            If (And (FLAG, 0x04))
                            {
                                Or (SYNC, 0x02, SYNC)
                                Store (SDMA (DMA1), SDT1)
                                If (LLess (DMA1, 0x1E))
                                {
                                    Or (ICR3, 0x02, ICR3)
                                }

                                If (LLess (DMA1, 0x3C))
                                {
                                    Or (ICR0, 0x02, ICR0)
                                }

                                If (And (W931, 0x2000))
                                {
                                    Or (ICR1, 0x02, ICR1)
                                }
                            }
                        }
                    }

                    Device (P_D0)
                    {
                        Name (_ADR, Zero)
                        Method (_RMV, 0, NotSerialized)
                        {
                            Return (Zero)
                        }

                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (PIB0, Buffer (0x0E)
                            {
                                /* 0000 */    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x03, 
                                /* 0008 */    0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                            })
                            CreateByteField (PIB0, One, PMD0)
                            CreateByteField (PIB0, 0x08, DMD0)
                            If (And (PRIT, 0x02))
                            {
                                If (LEqual (And (PRIT, 0x09), 0x08))
                                {
                                    Store (0x08, PMD0)
                                }
                                Else
                                {
                                    Store (0x0A, PMD0)
                                    ShiftRight (And (PRIT, 0x0300), 0x08, Local0)
                                    ShiftRight (And (PRIT, 0x3000), 0x0C, Local1)
                                    Add (Local0, Local1, Local2)
                                    If (LEqual (0x03, Local2))
                                    {
                                        Store (0x0B, PMD0)
                                    }

                                    If (LEqual (0x05, Local2))
                                    {
                                        Store (0x0C, PMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Store (One, PMD0)
                            }

                            If (And (SYNC, One))
                            {
                                Store (Or (SDT0, 0x40), DMD0)
                                If (And (ICR1, One))
                                {
                                    If (And (ICR0, One))
                                    {
                                        Add (DMD0, 0x02, DMD0)
                                    }

                                    If (And (ICR3, One))
                                    {
                                        Store (0x45, DMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD0, 0x07), 0x02), 0x20, DMD0)
                            }

                            Return (PIB0)
                        }
                    }

                    Device (P_D1)
                    {
                        Name (_ADR, One)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (PIB1, Buffer (0x0E)
                            {
                                /* 0000 */    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF, 0x03, 
                                /* 0008 */    0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                            })
                            CreateByteField (PIB1, One, PMD1)
                            CreateByteField (PIB1, 0x08, DMD1)
                            If (And (PRIT, 0x20))
                            {
                                If (LEqual (And (PRIT, 0x90), 0x80))
                                {
                                    Store (0x08, PMD1)
                                }
                                Else
                                {
                                    Add (And (PSIT, 0x03), ShiftRight (And (PSIT, 0x0C), 
                                        0x02), Local0)
                                    If (LEqual (0x05, Local0))
                                    {
                                        Store (0x0C, PMD1)
                                    }
                                    Else
                                    {
                                        If (LEqual (0x03, Local0))
                                        {
                                            Store (0x0B, PMD1)
                                        }
                                        Else
                                        {
                                            Store (0x0A, PMD1)
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                Store (One, PMD1)
                            }

                            If (And (SYNC, 0x02))
                            {
                                Store (Or (SDT1, 0x40), DMD1)
                                If (And (ICR1, 0x02))
                                {
                                    If (And (ICR0, 0x02))
                                    {
                                        Add (DMD1, 0x02, DMD1)
                                    }

                                    If (And (ICR3, 0x02))
                                    {
                                        Store (0x45, DMD1)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD1, 0x07), 0x02), 0x20, DMD1)
                            }

                            Return (PIB1)
                        }
                    }
                }
            }

            Device (SATA)
            {
                Name (_ADR, 0x001F0002)
                OperationRegion (SACS, PCI_Config, 0x40, 0xC0)
                Field (SACS, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16, 
                    SECT,   16, 
                    PSIT,   4, 
                    SSIT,   4, 
                            Offset (0x08), 
                    SYNC,   4, 
                            Offset (0x0A), 
                    SDT0,   2, 
                        ,   2, 
                    SDT1,   2, 
                            Offset (0x0B), 
                    SDT2,   2, 
                        ,   2, 
                    SDT3,   2, 
                            Offset (0x14), 
                    ICR0,   4, 
                    ICR1,   4, 
                    ICR2,   4, 
                    ICR3,   4, 
                    ICR4,   4, 
                    ICR5,   4, 
                            Offset (0x50), 
                    MAPV,   2
                }
            }

            Device (SBUS)
            {
                Name (_ADR, 0x001F0003)
            }
        }
    }
}

