import { Fragment } from 'inferno';
import { useBackend } from "../backend";
import { Box, Button, Collapsible, Icon, Input, LabeledList, Section, Tabs } from "../components";
import { ComplexModal, modalOpen, modalRegisterBodyOverride } from "../interfaces/common/ComplexModal";
import { Window } from "../layouts";
import { LoginInfo } from './common/LoginInfo';
import { LoginScreen } from './common/LoginScreen';
import { TemporaryNotice } from './common/TemporaryNotice';
import { decodeHtmlEntities } from 'common/string';

const doEdit = (context, field) => {
  modalOpen(context, 'edit', {
    field: field.edit,
    value: field.value,
  });
};

export const SecurityRecords = (_properties, context) => {
  const { data } = useBackend(context);
  const {
    authenticated,
    screen,
  } = data;
  if (!authenticated) {
    return (
      <Window
        width={700}
        height={680}
        resizable>
        <Window.Content>
          <LoginScreen />
        </Window.Content>
      </Window>
    );
  }

  let body;
  if (screen === 2) { // List Records
    body = <SecurityRecordsList />;
  } else if (screen === 3) { // Record Maintenance
    body = <SecurityRecordsMaintenance />;
  } else if (screen === 4) { // View Records
    body = <SecurityRecordsView />;
  }

  return (
    <Window
      width={700}
      height={680}
      resizable>
      <ComplexModal maxHeight="100%" maxWidth="400px" />
      <Window.Content className="Layout__content--flexColumn">
        <LoginInfo />
        <TemporaryNotice />
        <SecurityRecordsNavigation />
        <Section height="89%" flexGrow="1">
          {body}
        </Section>
      </Window.Content>
    </Window>
  );
};

const SecurityRecordsList = (_properties, context) => {
  const { act, data } = useBackend(context);
  const {
    records,
  } = data;
  return (
    <Fragment>
      <Input
        fluid
        placeholder="Поиск по Ф.И, ДНК, или ID"
        onChange={(_event, value) => act('search', { t1: value })}
      />
      <Box mt="0.5rem">
        {records.map((record, i) => (
          <Button
            key={i}
            icon="user"
            mb="0.5rem"
            color={record.color}
            content={record.id + ": " + record.name + " (Статус: " + record.criminal + ")"}
            onClick={() => act('d_rec', { d_rec: record.ref })}
          />
        ))}
      </Box>
    </Fragment>
  );
};

const SecurityRecordsMaintenance = (_properties, context) => {
  const { act } = useBackend(context);
  return (
    <Fragment>
      <Button
        icon="download"
        content="Резервное копирование на диск"
        disabled
      /><br />
      <Button
        icon="upload"
        content="Загрузить с диска"
        my="0.5rem"
        disabled
      /> <br />
      <Button.Confirm
        icon="trash"
        content="Удалить все записи без."
        onClick={() => act('del_all')}
      />
    </Fragment>
  );
};

const SecurityRecordsView = (_properties, context) => {
  const { act, data } = useBackend(context);
  const {
    security,
    printing,
  } = data;
  return (
    <Fragment>
      <Section title="Общие данные" level={2} mt="-6px">
        <SecurityRecordsViewGeneral />
      </Section>
      <Section title="Данные безопасности" level={2}>
        <SecurityRecordsViewSecurity />
      </Section>
      <Section title="Действия" level={2}>
        <Button.Confirm
          icon="trash"
          disabled={!!security.empty}
          content="Удалить запись безопасности"
          color="bad"
          onClick={() => act('del_r')}
        />
        <Button.Confirm
          icon="trash"
          disabled={!!security.empty}
          content="Удалить запись (все)"
          color="bad"
          onClick={() => act('del_r_2')}
        />        
        <Button
          icon={printing ? 'spinner' : 'print'}
          disabled={printing}
          iconSpin={!!printing}
          content="Печать страницы"
          ml="0.5rem"
          onClick={() => act('print_p')}
        /><br />
        <Button
          icon="arrow-left"
          content="Назад"
          mt="0.5rem"
          onClick={() => act('screen', { screen: 2 })}
        />
      </Section>
    </Fragment>
  );
};

const SecurityRecordsViewGeneral = (_properties, context) => {
  const { act, data } = useBackend(context);
  const {
    general,
  } = data;
  if (!general || !general.fields) {
    return (
      <Box color="bad">
        Общие данные потеряны!
      </Box>
    );
  }
  return (
    <Fragment>
      <Box width="50%" float="left">
        <LabeledList>
          {general.fields.map((field, i) => (
            <LabeledList.Item key={i} label={field.field}>
              <Box height="20px" display="inline-block">
                {field.value.split("\n").map(m => <Box key={m}>{m}</Box>)}
              </Box>
              {!!field.edit && (
                <Button
                  icon="pen"
                  ml="0.5rem"
                  onClick={() => doEdit(context, field)}
                />
              )}
            </LabeledList.Item>
          ))}
        </LabeledList>
      </Box>
      <Box width="50%" float="right" textAlign="right">
        {!!general.has_photos && (
          general.photos.map((p, i) => (
            <Box
              key={i}
              display="inline-block"
              textAlign="center"
              color="label">
              <img
                src={p.substr(1, p.length - 1)}
                style={{
                  width: '96px',
                  'margin-bottom': '0.5rem',
                  '-ms-interpolation-mode': 'nearest-neighbor',
                }}
              /><br />
              Фото #{i + 1}
            </Box>
          ))
        )}
        <Box>
          <Button onClick={() => act("photo_front")}>
            Обновить фронт фото
          </Button>
          <Button onClick={() => act("photo_side")}>
            Обновить задн. фото
          </Button>
        </Box>
      </Box>
    </Fragment>
  );
};

const SecurityRecordsViewSecurity = (_properties, context) => {
  const { act, data } = useBackend(context);
  const {
    security,
  } = data;
  if (!security || !security.fields) {
    return (
      <Box color="bad">
        Данные без. потеряны!
        <Button
          icon="pen"
          content="Новая запись"
          ml="0.5rem"
          onClick={() => act('new')}
        />
      </Box>
    );
  }
  return (
    <Fragment>
      <LabeledList>
        {security.fields.map((field, i) => (
          <LabeledList.Item
            key={i}
            label={field.field}>
            {field.value.split("\n").map(m => <Box key={m}>{m}</Box>)}
            <Button
              icon="pen"
              ml="0.5rem"
              mb={field.line_break ? '1rem' : 'initial'}
              onClick={() => doEdit(context, field)}
            />
          </LabeledList.Item>
        ))}
      </LabeledList>
      <Section title="Комментирование/Логирование" level={2}>
        {security.comments.length === 0 ? (
          <Box color="label">
            Нет комментариев.
          </Box>
        )
          : security.comments.map((comment, i) => (
            <Box key={i}>
              <Box color="label" display="inline">
                {comment.header}
              </Box><br />
              {comment.text}
              <Button
                icon="comment-slash"
                color="bad"
                ml="0.5rem"
                onClick={() => act('del_c', { del_c: i + 1 })}
              />
            </Box>
          ))}

        <Button
          icon="comment"
          content="Добавить запись"
          color="good"
          mt="0.5rem"
          mb="0"
          onClick={() => modalOpen(context, 'add_c')}
        />
      </Section>
    </Fragment>
  );
};

const SecurityRecordsNavigation = (_properties, context) => {
  const { act, data } = useBackend(context);
  const {
    screen,
  } = data;
  return (
    <Tabs>
      <Tabs.Tab
        selected={screen === 2}
        onClick={() => act('screen', { screen: 2 })}>
        <Icon name="list" />
        Список экипажа
      </Tabs.Tab>
      <Tabs.Tab
        selected={screen === 3}
        onClick={() => act('screen', { screen: 3 })}>
        <Icon name="wrench" />
        Ведение Документации
      </Tabs.Tab>
    </Tabs>
  );
};

